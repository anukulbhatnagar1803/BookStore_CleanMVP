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
}


class BookListViewController: UIViewController {
 
    @IBOutlet weak var bookListTableView: UITableView!
    var bookListPresenter: BookListPresenterProtocol!
    var bookList: [BookPresentationEntity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure BookList
        BookListConfigurator().configure(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookListPresenter.fetchCompleteBookList()
    }
}

extension BookListViewController: UITableViewDataSource, UITableViewDelegate, BookListDisplayProtocol {
    
    func displayBookList(bookList: [BookPresentationEntity]) {
        self.bookList = bookList
        bookListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = bookList[indexPath.row]
        cell.textLabel?.text = book.id
        cell.detailTextLabel?.text = book.name
        return cell
    }
    
    
    
}

