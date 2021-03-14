//
//  BooksService.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation
import RxSwift

protocol BooksServiceProtocol {
    func request(from endpoint: BooksApi) -> Observable<Books>
}

class BooksService: BooksServiceProtocol {
    
    func request(from endpoint: BooksApi) -> Observable<Books> {
        return RequestWrapper.request(from: endpoint.urlRequest)
    }
}
