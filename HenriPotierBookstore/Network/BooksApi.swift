//
//  BooksApi.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation

enum BooksApi {
    case getBooks
    case getBestOfferFor(books: [String])
}

extension BooksApi: APIBuilder {
    var urlRequest: URLRequest {
        URLRequest(url: self.baseURL.appendingPathComponent(path),
                   cachePolicy: .reloadIgnoringLocalCacheData)
    }
    
    var baseURL: URL {
        if let url = URL(string: AppConfig.baseUrlString) {
            return url
        } else {
            fatalError()
        }
    }
    
    var path: String {
        switch self {
        case .getBooks:
            return "/books"
        case let .getBestOfferFor(books):
            return "/books/{\(books.joined(separator: ","))}/commercialOffers"
        }
    }
}
