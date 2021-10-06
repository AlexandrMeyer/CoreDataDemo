//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Александр on 5.10.21.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    // Точка входа в базу данных
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    init() {}
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func getTask(from context: NSManagedObjectContext) -> Task? {
//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return nil }
//        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return nil }
//        return task
//    }
}

