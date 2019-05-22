//
//  BookListViewController.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 22/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {

    var bookType: BookType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = bookType?.rawValue
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
