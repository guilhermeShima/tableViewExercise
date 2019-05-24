//
//  AddBookViewController.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 22/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var yearTextField: UITextField!
    
    let datePicker = UIPickerView()
    
    var book: Book?
    
    let years: [String] = {
        var year: [String] = []
        //Looping to get years
        let currentYear = Calendar.current.component(.year, from: Date())
        for index in stride(from: currentYear, to: 1500, by: -1) {
            year.append(String(index))
        }
       return year
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearTextField.delegate = self
        showDatePicker()
        
        //Starting book values
        nameTextField.text = book?.name
        authorTextField.text = book?.author
        yearTextField.text = book?.yearOfPublication
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.dataSource = self
        datePicker.delegate = self
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneDatePicker));
        
        toolbar.setItems([doneButton], animated: true)
        
        yearTextField.inputAccessoryView = toolbar
        yearTextField.inputView = datePicker
    }
    
    @objc func doneDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
        //Validating data
        guard let name = nameTextField.text, !name.isEmpty,
            let author = authorTextField.text, !author.isEmpty,
            let year = yearTextField.text, !year.isEmpty else {
                showErrorAlert()
                return
        }
        
        if book == nil {
            book = Book(name: name, author: author, yearOfPublication: year)
        } else {
            book?.name = name
            book?.author = author
            book?.yearOfPublication = year
        }
        
        //In this case the book was supposed to be saved
        //¯\_(ツ)_/¯
        navigationController?.popViewController(animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Erro",
                                      message: "Preencha todos os campos para salvar o livro.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension AddBookViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[row]
        yearTextField.text = year
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
}

extension AddBookViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
}

extension AddBookViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == yearTextField {
            //Selecting first when picker is open
            if yearTextField.text?.isEmpty ?? true {
                yearTextField.text = years[0]
            }
        }
    }
}
