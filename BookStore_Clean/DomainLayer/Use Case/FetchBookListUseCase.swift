//
//  FetchBookListUseCase.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation

protocol FetchBookUseCaseProtocol {
    func fetchBookList() -> [BookPresentationEntity]
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
    
}
