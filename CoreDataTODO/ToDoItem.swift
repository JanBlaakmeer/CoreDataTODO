//
//  ToDoItem.swift
//  CoreDataTODO
//
//  Created by Jan Blaakmeer on 30/03/2020.
//  Copyright © 2020 Jan Blaakmeer. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject, Identifiable {
  @NSManaged public var createdAt: Date?
  @NSManaged public var title: String?
}

extension ToDoItem {

  static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
     let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as!
        NSFetchRequest<ToDoItem>
    
    let sortDesriptor = NSSortDescriptor(key: "createdAt", ascending: true)
    
    request.sortDescriptors = [sortDesriptor]
    
    return request
  }
}
