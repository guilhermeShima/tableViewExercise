//
//  StaticTableViewController.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 20/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import UIKit

class StaticTableViewController: UITableViewController {

    @IBOutlet weak var fantasyCell: UITableViewCell!
    
    @IBOutlet weak var scifiCell: UITableViewCell!
    
    @IBOutlet weak var novelCell: UITableViewCell!
    
    @IBOutlet weak var horrorCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Removing extra separator lines
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destination = segue.destination as? BookListViewController,
            let identifier = segue.identifier else { return }
        
        if identifier == "showListFromFantasy" {
            destination.bookType = .fantasy
        } else if identifier == "showListFromScifi" {
            destination.bookType = .sciFi
        } else if identifier == "showListFromHorror" {
            destination.bookType = .horror
        } else if identifier == "showListFromNovel" {
            destination.bookType = .novel
        }
    }
}
