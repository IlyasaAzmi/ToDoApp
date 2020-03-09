//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Ilyasa Azmi on 09/03/20.
//  Copyright © 2020 Ilyasa Azmi. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem: NSManagedObject, Identifiable {
    @NSManaged public var cratedAt : String
    @NSManaged public var title : String
}

extension ToDoItem {
    static func getAllDataItems() -> NSFetchRequest<ToDoItem> {
        let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
