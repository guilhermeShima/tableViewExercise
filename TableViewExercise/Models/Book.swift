//
//  Book.swift
//  TableViewExercise
//
//  Created by Guilherme Tavares Shimamoto on 22/05/19.
//  Copyright © 2019 Guilherme Shimamoto. All rights reserved.
//

import Foundation

public class Book {
    var name: String
    var author: String
    var yearOfPublication: Date
    var hasBeenRead: Bool
    
    init(name: String, author: String, yearOfPublication: Date) {
        self.name = name
        self.author = author
        self.yearOfPublication = yearOfPublication
        self.hasBeenRead = false
    }
}
