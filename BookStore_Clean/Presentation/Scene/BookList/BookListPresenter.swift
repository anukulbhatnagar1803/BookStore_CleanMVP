//
//  BookListPresenter.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol BookListPresenterProtocol {
    func fetchCompleteBookList()
    func fetchBook(at indexPath: IndexPath) -> BookPresentationEntity
    func initializeBookList()
    func bookListCount() -> Int
}

class BookListPresenter: BookListPresenterProtocol {
    
    private weak var viewController: BookListViewController!
    private var fetchBookListUseCase: FetchBookUseCaseProtocol
 
    init(_ viewController: BookListViewController,
         _ fetchBookListUseCase: FetchBookUseCaseProtocol) {
        self.viewController = viewController
        self.fetchBookListUseCase = fetchBookListUseCase
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(newBookAddedCallBack(notification:)),
                                               name: NSNotification.Name(rawValue: "InsertNewBook"),
                                               object: nil)
    }
    
    func fetchCompleteBookList() {
        let bookList = fetchBookListUseCase.fetchBookList()
        viewController.displayBookList(bookList: bookList)
    }
    
    func fetchBook(at indexPath: IndexPath) -> BookPresentationEntity {
        return fetchBookListUseCase.fetchBook(at: indexPath)
    }
    
    func initializeBookList() {
        fetchBookListUseCase.initializeBookList()
    }
    
    func bookListCount() -> Int {
        return fetchBookListUseCase.bookListCount()
    }
    
    @objc func newBookAddedCallBack(notification: NSNotification) {
    
        if let indexPath = notification.object as? IndexPath {
            viewController.insertRow(indexPath: indexPath)
        }
    }
}
