//
//  CreateBookConfigurator.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation


class CreateBookConfigurator<T: CreateBookViewController> {
    
    static func configure(controller: T) {
        //let bookService = BookService(service: DBService.shared)
        let createBookRepository = BookRepository(service: DBService.shared)
        let createBookUseCase = CreateBookUseCase(bookRepo: createBookRepository)
        let createBookPresenter = CreateBookPresenter(controller, createBookUseCase)
        controller.createBookPresenter = createBookPresenter
    }
    
    
}
