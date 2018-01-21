//
//  FetchBookListUseCase.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol FetchBookUseCaseProtocol {
    func fetchBookList() -> [BookPresentationEntity]
    func fetchBook(at indexPath: IndexPath) -> BookPresentationEntity
    func initializeBookList()
    func bookListCount() -> Int
}

struct FetchBookListUseCase: FetchBookUseCaseProtocol {
    
    private var bookRepository: BookRepositoryProtocol
    
    init(bookRepo: BookRepositoryProtocol) {
        self.bookRepository = bookRepo
    }
    
    func fetchBookList() -> [BookPresentationEntity] {
        
        let bookList = bookRepository.fetchCompleteBookList()
        var bookPresentationEntityList: [BookPresentationEntity] = []
        bookList.forEach { (bookDomainEntity) in
            bookPresentationEntityList.append(BookPresentationEntity(name: bookDomainEntity.name,
                                                                     id: bookDomainEntity.id))
        }
        return bookPresentationEntityList
    }
    
    func fetchBook(at indexPath: IndexPath) -> BookPresentationEntity {
        let bookDomainEntity = bookRepository.fetchBook(at: indexPath)
        return BookPresentationEntity(name: bookDomainEntity.name,
                                      id: bookDomainEntity.id)
    }
    
    func initializeBookList() {
        bookRepository.initializeBookList()
    }
    
    func bookListCount() -> Int {
        return bookRepository.bookListCount()
    }
    
}
