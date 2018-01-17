//
//  BookListPresenter.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation

protocol BookListPresenterProtocol {
    func fetchCompleteBookList()
}

class BookListPresenter: BookListPresenterProtocol {
    
    private weak var viewController: BookListViewController!
    private var fetchBookListUseCase: FetchBookUseCaseProtocol
 
    init(_ viewController: BookListViewController,
         _ fetchBookListUseCase: FetchBookUseCaseProtocol) {
        self.viewController = viewController
        self.fetchBookListUseCase = fetchBookListUseCase
    }
    
    func fetchCompleteBookList() {
        let bookList = fetchBookListUseCase.fetchBookList()
        viewController.displayBookList(bookList: bookList)
    }
    
}
