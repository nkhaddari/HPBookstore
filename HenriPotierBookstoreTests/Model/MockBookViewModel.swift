//
//  MockBookViewModel.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 13/03/2021.
//

import Foundation
@testable import HenriPotierBookstore

extension BookViewModel {
    static func booksViewModelMock() -> [BookViewModel] {
        return Book.booksMock().map { BookViewModel(book: $0) }
    }
    
    static func selectedBooksViewModelMock() -> [BookViewModel] {
        return booksViewModelMock().map {
            var book = $0
            book.quantity = 1
            return book
        }
    }
}
