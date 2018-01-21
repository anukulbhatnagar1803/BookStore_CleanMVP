//
//  BookService.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreData

protocol BookServiceProtocol {
    func fetchCompleteBookList() -> [Book]
    func createBook(bookName: String, bookID: String, completion: @escaping (Bool, Error?) -> Void)
    func fetchBook(at indexPath: IndexPath) -> Book
    func initializeBookList()
    func bookListCount() -> Int
}

class BookService: NSObject, BookServiceProtocol {
    
    private let dbService: DBService
    
    
    private lazy var bookFetchResultController: NSFetchedResultsController<Book> = {
        let sortDescriptor = NSSortDescriptor(key: "bookName", ascending: true)
        let fetchResultController = dbService.createFetchResultController(entity: Book.self,
                                                                          predicate: nil,
                                                                          delegate: self,
                                                                          sortDescriptors: [sortDescriptor],
                                                                          onContext: dbService.mainContext)
        return fetchResultController
    }()
    
    init(service: DBService) {
        self.dbService = service
    }
    
    func fetchCompleteBookList() -> [Book] {
        //Logic to fetch book list
        return dbService.fetchEntities(entity: Book.self,
                                       onContext: dbService.mainContext)
    }
    
    func createBook(bookName: String,
                    bookID: String,
                    completion: @escaping (Bool, Error?) -> Void) {
        
        let predicate = NSPredicate(format: "bookID == %@", bookID)
        let bookArray = dbService.fetchEntities(entity: Book.self,
                                           onContext: dbService.mainContext,
                                           predicate: predicate)
        
        guard bookArray.count == 0 else {
            completion(false, NSError())
            return
        }
        
        let book = dbService.createEntity(entity: Book.self, onContext: dbService.mainContext)
        book?.bookName = bookName
        book?.bookID = bookID
        
        do {
            try dbService.mainContext.save()
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }
    
    func initializeBookList() {
        do {
            try self.bookFetchResultController.performFetch()
        } catch {
            print("Error while initializing Book List")
        }
    }
    
    func bookListCount() -> Int {
        if self.bookFetchResultController.fetchedObjects == nil {
            initializeBookList()
        }
        return self.bookFetchResultController.fetchedObjects?.count ?? 0
    }
    
    func fetchBook(at indexPath: IndexPath) -> Book {
        return bookFetchResultController.object(at: indexPath)
    }
}

extension BookService: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            print("Insert")
            break
        case .delete:
            print("Delete")
            break
        case .update:
            print("Update")
            break
        case .move:
            print("Move")
            break
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
}
