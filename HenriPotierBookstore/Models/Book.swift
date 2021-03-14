//
//  Book.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation

struct Book: Codable {
    let isbn, title: String
    let price: Int
    let cover: String
    let synopsis: [String]?
}

typealias Books = [Book]
