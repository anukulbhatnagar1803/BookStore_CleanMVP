//
//  CreateBookViewController.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import UIKit



class CreateBookViewController: UIViewController {
    
    var createBookPresenter: CreateBookPresenterProtocol!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bookIDTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateBookConfigurator.configure(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func createBookAction(_ sender: Any) {
    
        guard let bookName = nameTextField.text, let bookID = bookIDTextField.text else {
            return
        }
        
        let bookPresentationEntity = BookPresentationEntity(name: bookName, id: bookID)
        createBookPresenter.createBook(entity: bookPresentationEntity)
        self.navigationController?.popViewController(animated: true)
    }
}

