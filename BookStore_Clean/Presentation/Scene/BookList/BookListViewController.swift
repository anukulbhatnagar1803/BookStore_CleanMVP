//
//  BookListViewController.swift
//  BookStore_Clean
//
//  Created by administrator on 1/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation
import UIKit

protocol  BookListDisplayProtocol {
    func displayBookList(bookList: [BookPresentationEntity])
    
    
    func insertRow(indexPath: IndexPath)
    func deleteRow(indexPath: IndexPath)
    func updateRow(indexPath: IndexPath)
    func beginUpdate()
    func endUpdate()
    func initializeBookList()
}


class BookListViewController: UIViewController {
 
    @IBOutlet weak var bookListTableView: UITableView!
    var bookListPresenter: BookListPresenterProtocol!
    var bookList: [BookPresentationEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure BookList
        BookListConfigurator().configure(controller: self)
        initializeBookList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: Need to remove this
        bookListTableView.reloadData()
    }
}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate, BookListDisplayProtocol {
    
    func displayBookList(bookList: [BookPresentationEntity]) {
        self.bookList = bookList
        bookListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookListPresenter.bookListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = bookListPresenter.fetchBook(at: indexPath)
        cell.textLabel?.text = book.id
        cell.detailTextLabel?.text = book.name
        return cell
    }
    
    func initializeBookList() {
        bookListPresenter.initializeBookList()
    }
    
    func beginUpdate() {
        bookListTableView.beginUpdates()
    }
    
    func insertRow(indexPath: IndexPath) {
        bookListTableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func deleteRow(indexPath: IndexPath) {
        bookListTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func updateRow(indexPath: IndexPath) {
        bookListTableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func endUpdate() {
        bookListTableView.endUpdates()
    }
}

