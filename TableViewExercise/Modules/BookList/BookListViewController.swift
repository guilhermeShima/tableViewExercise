//
//  BookListViewController.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 22/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import UIKit
import MobileCoreServices

class BookListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBookButton: UIButton!
    
    var bookType: BookType?
    
    var unreadBooks: [Book] = [
        Book(name: "Harry Potter e o Cálice de Fogo", author: "J. K. Rowling", yearOfPublication: Date()),
    ]
    
    var readbooks: [Book] = [
        Book(name: "Eu, Robô", author: "Isaac Asimov", yearOfPublication: Date()),
        Book(name: "Neuromancer", author: "William Gibson", yearOfPublication: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting title
        navigationItem.title = bookType?.rawValue
        
        //Setting table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        //Registering nibs
        let nib = UINib.init(nibName: "BookTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "bookTableViewCell")

        let header = UINib.init(nibName: "BookHeaderView", bundle: nil)
        tableView.register(header, forHeaderFooterViewReuseIdentifier: "bookHeaderView")
    }
    
    @IBAction func didTapEdit(_ sender: Any) {
        let isEditing = tableView.isEditing
        
        let enabledColor = UIColor(red: 175/255, green: 230/255, blue: 132/255, alpha: 1)
        let disabledColor = UIColor(red: 175/255, green: 230/255, blue: 132/255, alpha: 0.5)
        addBookButton.isEnabled = isEditing
        addBookButton.backgroundColor = isEditing ? enabledColor : disabledColor
        
        tableView.isEditing = !isEditing

        navigationItem.rightBarButtonItem?.title = isEditing ? "Edit" : "Done"
    }
}

extension BookListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Table cell functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return unreadBooks.count
        }
        return readbooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookTableViewCell") as? BookTableViewCell
        guard let bookCell = cell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            bookCell.configure(for: unreadBooks[indexPath.row])
        } else {
            bookCell.configure(for: readbooks[indexPath.row])
        }
        return bookCell
    }
    
    //Move cells functions
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let fromSection = sourceIndexPath.section
        let toSection = destinationIndexPath.section
        
        if fromSection == 0 {
            let item = unreadBooks[sourceIndexPath.row]
            
            if fromSection == toSection {
                //moved book to same session
                unreadBooks.remove(at: sourceIndexPath.row)
                unreadBooks.insert(item, at: destinationIndexPath.row)
            } else {
                //move book between sessions and update book status
                unreadBooks.remove(at: sourceIndexPath.row)
                readbooks.insert(item, at: destinationIndexPath.row)
                item.updateReadStatus()
            }
        } else {
            let item = readbooks[sourceIndexPath.row]
            
            if fromSection == toSection {
                //moved book to same session
                readbooks.remove(at: sourceIndexPath.row)
                readbooks.insert(item, at: destinationIndexPath.row)
            } else {
                //move book between sessions and update book status
                readbooks.remove(at: sourceIndexPath.row)
                unreadBooks.insert(item, at: destinationIndexPath.row)
                item.updateReadStatus()
            }
        }
    }
    
    //Editing table view functions
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            if indexPath.section == 0 {
                unreadBooks.remove(at: indexPath.row)

            } else {
                readbooks.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "bookHeaderView") as? BookHeaderView
        guard let headerView = view else { return UIView() }
        
        if section == 0 {
            headerView.configure(title: "Não lidos")
        } else {
            headerView.configure(title: "Lidos")
        }
        return headerView
    }
}
