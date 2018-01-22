//
//  CreateBookPresenter.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation




protocol CreateBookPresenterProtocol {
    func createBook(entity: BookPresentationEntity)
}


class CreateBookPresenter: CreateBookPresenterProtocol {
    
    private var viewController: CreateBookViewController!
    private var createBookUseCase: CreateBookUseCaseProtocol!
    
    
    init(_ controller: CreateBookViewController,
         _ useCase: CreateBookUseCaseProtocol) {
        
        self.viewController = controller
        self.createBookUseCase = useCase
    }
    
    func createBook(entity: BookPresentationEntity) {
        let bookDomainEntity = BookDomainEntity(name: entity.name, id: entity.id)
        
        createBookUseCase.createBook(domainEntity: bookDomainEntity) { [weak self] (result) in
            switch result {
            case let .success(bookDomainModel):
                let object = BookPresentationEntity(name: bookDomainModel.name ,
                                                    id: bookDomainModel.id)
               
                self?.viewController.bookCreationSuccess(viewEntity: object)
                break
                
            case let .failure(error):
                var errorString = ""
                if case let BookModelError.InsertFailure(errorStr) = error {
                    errorString = errorStr
                }
                self?.viewController.bookCreationFailure(errorString: errorString)
                break
            }
        }
    }
}
