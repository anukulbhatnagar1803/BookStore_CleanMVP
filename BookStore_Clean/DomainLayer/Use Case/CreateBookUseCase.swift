//
//  CreateBookUseCase.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation

protocol  CreateBookUseCaseProtocol {
    
    func createBook(domainEntity: BookDomainEntity, completion: @escaping (Bool, Error?) -> Void)
}

struct CreateBookUseCase: CreateBookUseCaseProtocol {
    
    private var bookRepository: BookRepositoryProtocol
    
    init(bookRepo: BookRepositoryProtocol) {
        self.bookRepository = bookRepo
    }
    
    func createBook(domainEntity: BookDomainEntity,
                    completion: @escaping (Bool, Error?) -> Void) {
        
        bookRepository.createBook(entity: domainEntity)
        {   (isBookCreated, error) in
            completion(isBookCreated, error)
        }
    }
    
    
    func createBook(domainEntity: BookDomainEntity) {
        
    }
    
}
