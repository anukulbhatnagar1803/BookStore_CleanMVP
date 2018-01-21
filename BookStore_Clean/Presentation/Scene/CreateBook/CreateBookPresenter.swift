//
//  CreateBookPresenter.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol CreateBookPresenterProtocol {
    func createBook(entity: BookPresentationEntity,
                    completion: @escaping (Bool, Error?) -> Void)
}


class CreateBookPresenter: CreateBookPresenterProtocol {
    
    private var viewController: CreateBookViewController!
    private var createBookUseCase: CreateBookUseCaseProtocol!
    
    
    init(_ controller: CreateBookViewController,
         _ useCase: CreateBookUseCaseProtocol) {
        
        self.viewController = controller
        self.createBookUseCase = useCase
    }
    
    func createBook(entity: BookPresentationEntity,
                    completion: @escaping (Bool, Error?) -> Void) {
        let bookDomainEntity = BookDomainEntity(name: entity.name, id: entity.id)
        createBookUseCase.createBook(domainEntity: bookDomainEntity)
        {   (isBookCreated, error) in
            completion(isBookCreated, error)
        }
    }
}
