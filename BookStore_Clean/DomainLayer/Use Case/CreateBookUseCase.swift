//
//  CreateBookUseCase.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

typealias BookUseCaseCreateBookCompletionHandler = (BookModelResult<BookDomainEntity>) -> Void
protocol  CreateBookUseCaseProtocol {
    
    func createBook(domainEntity: BookDomainEntity,
                    completion: @escaping BookUseCaseCreateBookCompletionHandler)
}

struct CreateBookUseCase: CreateBookUseCaseProtocol {
    
    private var bookRepository: BookRepositoryProtocol
    
    init(bookRepo: BookRepositoryProtocol) {
        self.bookRepository = bookRepo
    }
    
    func createBook(domainEntity: BookDomainEntity,
                    completion: @escaping BookUseCaseCreateBookCompletionHandler) {
        
        bookRepository.createBook(entity: domainEntity) { (result) in
            
            switch result {
            case let .success(bookModel):
                let object = BookDomainEntity(name: bookModel.bookName ?? "",
                                              id: bookModel.bookID ?? "")
                completion(BookModelResult.success(object))
                break
                
            case let .failure(error):
                
                completion(BookModelResult.failure(error))
                break
            }
        }
    }
    
    
    func createBook(domainEntity: BookDomainEntity) {
        
    }
    
}
