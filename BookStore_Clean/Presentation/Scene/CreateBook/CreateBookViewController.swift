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
        
        createBookPresenter.createBook(entity: bookPresentationEntity) { [weak self] (isBookCreated, error) in
            self?.showAlert(error: error)
        }
    }
    
    // MARK: Show Alert
    func showAlert(error: Error?) {
        var title = "Success"
        var message = "Successfully created new book"
        if error != nil {
            title = "Error"
            message = "Error While creating new book"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        {   [weak self] (action) in
            //TODO : Call on Main Thread
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        //TODO : Call on Main Thread
        self.present(alert, animated: true, completion: nil)
    }
}

