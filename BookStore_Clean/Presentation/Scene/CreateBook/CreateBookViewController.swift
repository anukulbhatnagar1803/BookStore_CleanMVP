//
//  CreateBookViewController.swift
//  BookStore_Clean
//
//  Created by administrator on 1/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

protocol CreateBookProtocol {
    
    func bookCreationSuccess(viewEntity: BookPresentationEntity)
    func bookCreationFailure(errorString: String)
}



class CreateBookViewController: UIViewController, CreateBookProtocol {
    
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
    }
    
    
    // MARK: Create Book Protocol
    func bookCreationSuccess(viewEntity: BookPresentationEntity) {
        print("Success while creating new book")
        showSuccessAlert()
    }
    
    func bookCreationFailure(errorString: String) {
        print("Error while creating new book \(errorString)")
        showErrorAlert(errorMessage: errorString)
        
    }
    
    // MARK: Show Alert
    func showErrorAlert(errorMessage: String) {
        showAlert(title: "Error", message: errorMessage)
    }
    
    func showSuccessAlert() {
        let alert = UIAlertController(title: "Success", message: "Successfully created new book", preferredStyle: .alert)
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
    
    
    func showAlert(title: String, message: String) {
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

