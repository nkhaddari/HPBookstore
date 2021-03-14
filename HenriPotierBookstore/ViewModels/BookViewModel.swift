//
//  BookViewModel.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 05/03/2021.
//

import Foundation

struct BookViewModel {
    let isbn, title: String
    let price: Int
    let cover: URL?
    let synopsis: [String]?
    var quantity = 0
    
    init(book: Book) {
        isbn = book.isbn
        title = book.title
        price = book.price
        cover = URL(string: book.cover)
        synopsis = book.synopsis
        quantity = 0
    }
}

extension BookViewModel: Equatable {
    
}
