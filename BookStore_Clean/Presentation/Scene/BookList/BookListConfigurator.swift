//
//  BookListConfigurator.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class BookListConfigurator<T: BookListViewController> {
    
    func configure(controller: T) {
        let bookService = BookService(service: DBService.shared)
        let bookRepository = BookRepository(service: bookService)
        let fetchBookListUseCase = FetchBookListUseCase(bookRepo: bookRepository)
        let bookListpresenter = BookListPresenter.init(controller, fetchBookListUseCase)
        controller.bookListPresenter = bookListpresenter
    }
    
}
