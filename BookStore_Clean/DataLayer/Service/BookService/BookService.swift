//
//  BookService.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation


protocol BookServiceProtocol {
    func fetchCompleteBookList() -> [Book]
    func createBook(bookName: String, bookID: String)
}

struct BookService: BookServiceProtocol {
    
    private let dbService: DBService
    
    init(service: DBService) {
        self.dbService = service
    }
    
    func fetchCompleteBookList() -> [Book] {
        //Logic to fetch book list
        return dbService.fetchEntities(entity: Book.self,
                                       onContext: dbService.mainContext)
    }
    
    
    func createBook(bookName: String, bookID: String) {
        
        let book = dbService.createEntity(entity: Book.self, onContext: dbService.mainContext)
        book?.bookName = bookName
        book?.bookID = bookID
        //Changes New Changes
        dbService.saveContext()
    }
    
}
