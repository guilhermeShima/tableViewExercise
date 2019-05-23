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
        Book(name: "Livro Teste n lido", author: "Joao siLVA ODVO IO", yearOfPublication: Date()),
    ]
    
    var readbooks: [Book] = [
        Book(name: "Livro Teste", author: "Joao siLVA ODVO IO", yearOfPublication: Date()),
        Book(name: "Bla", author: "Blw", yearOfPublication: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting title
        navigationItem.title = bookType?.rawValue
        
        //Setting table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        let nib = UINib.init(nibName: "BookTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "bookTableViewCell")

        let header = UINib.init(nibName: "BookHeaderView", bundle: nil)
        tableView.register(header, forHeaderFooterViewReuseIdentifier: "bookHeaderView")
    }
    
    @IBAction func didTapEdit(_ sender: Any) {
        let isEditing = tableView.isEditing
        
        let enabledColor = UIColor(red: 175/255, green: 230/255, blue: 132/255, alpha: 1)
        let disabledColor = UIColor(red: 175/255, green: 230/255, blue: 132/255, alpha: 0.5)
        
        tableView.isEditing = !isEditing
        addBookButton.isEnabled = isEditing

        navigationItem.rightBarButtonItem?.title = isEditing ? "Edit" : "Done"
        addBookButton.backgroundColor = isEditing ? enabledColor : disabledColor
    }
}

extension BookListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let fromSection = sourceIndexPath.section
        let toSection = destinationIndexPath.section
        
        if fromSection == 0 {
            let item = unreadBooks[sourceIndexPath.row]
            
            //moved book to same session
            if fromSection == toSection {
                unreadBooks.remove(at: sourceIndexPath.row)
                unreadBooks.insert(item, at: destinationIndexPath.row)
            } else {
                unreadBooks.remove(at: sourceIndexPath.row)
                readbooks.insert(item, at: destinationIndexPath.row)
            }
        } else {
            let item = readbooks[sourceIndexPath.row]
            
            //moved book to same session
            if fromSection == toSection {
                readbooks.remove(at: sourceIndexPath.row)
                readbooks.insert(item, at: destinationIndexPath.row)
            } else {
                readbooks.remove(at: sourceIndexPath.row)
                unreadBooks.insert(item, at: destinationIndexPath.row)
            }
        }
    }
}

extension BookListViewController: UITableViewDelegate {
}
