//
//  CoreDataStack.swift
//  Galaxy App
//
//  Created by Ko Kyaw on 09/08/2021.
//

import Foundation
import CoreData

final class CoreDataStack: NSObject {
    
    static let shared = CoreDataStack()
    
    private override init() {}
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GalaxyApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context: NSManagedObjectContext = {
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return container.viewContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
