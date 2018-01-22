//
//  BookRepository.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//


import Foundation
import CoreData

protocol BookRepositoryProtocol {
    func fetchCompleteBookList() -> [BookDomainEntity]
    func createBook(entity: BookDomainEntity, completion: @escaping (Bool, Error?) -> Void)
    func fetchBook(at indexPath: IndexPath) -> BookDomainEntity
    func initializeBookList()
    func bookListCount() -> Int
}


class BookRepository: NSObject, BookRepositoryProtocol, NSFetchedResultsControllerDelegate {
    
    private let dbService: DBService
    init(service: DBService) {
        self.dbService = service
    }
    
    private lazy var bookFetchResultController: NSFetchedResultsController<Book> = {
        let sortDescriptor = NSSortDescriptor(key: "bookName", ascending: true)
        let fetchResultController = dbService.createFetchResultController(entity: Book.self,
                                                                          predicate: nil,
                                                                          delegate: self,
                                                                          sortDescriptors: [sortDescriptor],
                                                                          onContext: dbService.mainContext)
        return fetchResultController
    }()
    
    
    func fetchCompleteBookList() -> [BookDomainEntity] {
        let bookList = dbService.fetchEntities(entity: Book.self,
                                               onContext: dbService.mainContext)
        var bookDomainList: [BookDomainEntity] = []
        bookList.forEach { (bookModel) in
            bookDomainList.append(BookDomainEntity(name: bookModel.bookName ?? "NA",
                                                   id: bookModel.bookID ?? "NA"))
        }
        return bookDomainList
    }
    
    func createBook(entity: BookDomainEntity, completion: @escaping (Bool, Error?) -> Void) {
        
        let predicate = NSPredicate(format: "bookID == %@", entity.id)
        let bookArray = dbService.fetchEntities(entity: Book.self,
                                                onContext: dbService.mainContext,
                                                predicate: predicate)
        
        guard bookArray.count == 0 else {
            completion(false, NSError())
            return
        }
        
        let book = dbService.createEntity(entity: Book.self,
                                          onContext: dbService.mainContext)
        book?.bookName = entity.name
        book?.bookID = entity.id
        
        do {
            try dbService.mainContext.save()
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }
    
    
    func fetchBook(at indexPath: IndexPath) -> BookDomainEntity {
        let object = bookFetchResultController.object(at: indexPath)
        return BookDomainEntity(name: object.bookName ?? "",
                                id: object.bookID ?? "")
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
    
}
