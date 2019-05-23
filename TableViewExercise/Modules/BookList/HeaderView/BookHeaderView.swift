//
//  BookHeaderView.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 23/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import UIKit

class BookHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
      
    public func configure(title: String) {
        titleLabel.text = title
    }
}
