//
//  ContentView.swift
//  CoreDataTODO
//
//  Created by Jan Blaakmeer on 30/03/2020.
//  Copyright © 2020 Jan Blaakmeer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
    
    @State private var newTodoitem = ""
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Whats next")) {
                    HStack{
                        TextField("New Item", text: self.$newTodoitem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newTodoitem
                            toDoItem.createdAt = Date()
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            self.newTodoitem = ""
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                            }
                    }
                }.font(.headline)
                Section(header: Text("To Do's")) {
                    ForEach(self.toDoItems) { toDoItem in                   ToDoItemView(title: toDoItem.title!, createdAt: "\(toDoItem.createdAt!)")
                    }.onDelete { indexSet in
                        let deleteItem = self.toDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("My ToDO list"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
