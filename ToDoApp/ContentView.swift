//
//  ContentView.swift
//  ToDoApp
//
//  Created by Ilyasa Azmi on 09/03/20.
//  Copyright © 2020 Ilyasa Azmi. All rights reserved.
//

//import Foundation
import UIKit
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllDataItems()) var toDoItems: FetchedResults<ToDoItem>
    
    @State private var newToDoItem = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("What's Next")) {
                    HStack {
                        TextField("New Item", text: self.$newToDoItem)
                        Button(action : {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
//                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newToDoItem = ""
                            
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }
                
                Section(header: Text("To Dos")) {
                    ForEach(self.toDoItems) { toDoItem in
                        ToDoItemView(title: toDoItem.title, createdAt: "ok")
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
            .navigationBarTitle(Text("My To Dos"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
