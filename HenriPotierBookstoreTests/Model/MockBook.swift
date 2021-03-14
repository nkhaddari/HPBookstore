//
//  MockBook.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 12/03/2021.
//

import Foundation
@testable import HenriPotierBookstore
extension Book {
    static func booksMock() -> Books {
        let books: Books = [Book(isbn: "fcd1e6fa-a63f-4f75-9da4-b560020b6acc",
                                 title: "Henri Potier et le Prisonnier d'Azkaban",
                                 price: 30,
                                 cover: "http://henri-potier.xebia.fr/hp2.jpg",
                                 synopsis: nil),
                            Book(isbn: "a460afed-e5e7-4e39-a39d-c885c05db861",
                                 title: "Henri Potier et la Chambre des secrets",
                                 price: 30,
                                 cover: "http://henri-potier.xebia.fr/hp1.jpg",
                                 synopsis: nil),
                            Book(isbn: "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
                                 title: "Henri Potier à l'école des sorciers",
                                 price: 35,
                                 cover: "http://henri-potier.xebia.fr/hp0.jpg",
                                 synopsis: nil)]
        
        return books
    }
}
