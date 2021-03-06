//
//  BookRepository.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol BookRepositoryProtocol {
    func fetchCompleteBookList() -> [BookDomainEntity]
    func createBook(entity: BookDomainEntity, completion: @escaping (Bool, Error?) -> Void)
    func fetchBook(at indexPath: IndexPath) -> BookDomainEntity
    func initializeBookList()
    func bookListCount() -> Int
}


struct BookRepository: BookRepositoryProtocol {
    
    private let bookService: BookServiceProtocol
    
    init(service: BookServiceProtocol) {
        self.bookService = service
    }
    
    func fetchCompleteBookList() -> [BookDomainEntity] {
        let bookList = bookService.fetchCompleteBookList()
        var bookDomainList: [BookDomainEntity] = []
        bookList.forEach { (bookModel) in
            bookDomainList.append(BookDomainEntity(name: bookModel.bookName ?? "NA",
                                                   id: bookModel.bookID ?? "NA"))
        }
        return bookDomainList
    }
    
    func createBook(entity: BookDomainEntity, completion: @escaping (Bool, Error?) -> Void) {
        bookService.createBook(bookName: entity.name,
                               bookID: entity.id)
        {   (isBookCreated, error) in
            completion(isBookCreated, error)
        }
    }
    
    func createBook(entity: BookDomainEntity) {
        
    }
    
    func fetchBook(at indexPath: IndexPath) -> BookDomainEntity {
        let bookModelEntity = bookService.fetchBook(at: indexPath)
        //TODO: Need to fix the same
        return BookDomainEntity(name: bookModelEntity.bookName ?? "",
                                id: bookModelEntity.bookID ?? "")
        
    }
    
    func initializeBookList() {
        bookService.initializeBookList()
    }
    
    func bookListCount() -> Int {
        return bookService.bookListCount()
    }
    
}
