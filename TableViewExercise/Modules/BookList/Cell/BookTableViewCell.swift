//
//  BookTableViewCell.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 22/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(for book: Book) {
        nameLabel.text = book.name
        authorLabel.text = book.author + ", \(book.yearOfPublication)"
    }
}
