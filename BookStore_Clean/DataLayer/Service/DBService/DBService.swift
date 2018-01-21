//
//  DBService.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreData

class DBService {
    
    // DBManager singleton.
    static let shared = DBService()
    
    private init() { }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BookStore_Clean")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK:
    var mainContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    // MARK:
    func createEntity<T: NSManagedObject>(entity: T.Type,
                                          onContext: NSManagedObjectContext) -> T? {
        let entityName = String(describing: entity)
        return NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                   into: onContext) as? T
    }
    
    
    func fetchOrCreateEntity<T: NSManagedObject>(entity: T.Type,
                                                 predicate: NSPredicate,
                                                 onContext: NSManagedObjectContext) -> T? {
        
        let objectArray = self.fetchEntities(entity: entity, onContext: onContext, predicate: predicate)
        
        if objectArray.count == 1 {
            return objectArray.first
        }
        
        if objectArray.count > 1 {
            return nil
        }
        
        return createEntity(entity: entity, onContext: onContext)
    }
    
    
    func fetchEntities<T: NSManagedObject>(entity: T.Type,
                                           onContext: NSManagedObjectContext,
                                           predicate: NSPredicate? = nil,
                                           sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = createFetchRequest(entity: entity,
                                              predicate: predicate,
                                              sortDescriptors: sortDescriptors)
        var entityList: [T] = []
        
        do {
            entityList = try onContext.fetch(fetchRequest)
        } catch {
            print("Error while fetching entities")
        }
        
        return entityList
    }
    
    func createFetchRequest<T: NSManagedObject>(entity: T.Type,
                                                predicate: NSPredicate? = nil,
                                                sortDescriptors: [NSSortDescriptor]? = nil ) -> NSFetchRequest<T> {
        
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    func createFetchResultController<T: NSManagedObject>(entity: T.Type,
                                                         predicate: NSPredicate? = nil,
                                                         delegate: NSFetchedResultsControllerDelegate,
                                                         sortDescriptors: [NSSortDescriptor],
                                                         onContext: NSManagedObjectContext) -> NSFetchedResultsController<T> {
        
        let fetchRequest = createFetchRequest(entity: entity,
                                              predicate: predicate,
                                              sortDescriptors: sortDescriptors)
        
        let fetchResultController = NSFetchedResultsController<T>(fetchRequest: fetchRequest,
                                                                  managedObjectContext: onContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchResultController.delegate = delegate
        return fetchResultController
        
    }
    
    
}
