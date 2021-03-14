//
//  MockBookService.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 13/03/2021.
//

import Foundation
import RxSwift
@testable import HenriPotierBookstore

final class MockBookService: BooksServiceProtocol {
    var books: Books
    var error: APIError
    var isSuccess: Bool
    
    init(books: Books = Book.booksMock(),
         error: APIError = .decode,
         success: Bool = true) {
        self.books = books
        self.error = error
        self.isSuccess = success
    }
    
    func request(from endpoint: BooksApi) -> Observable<Books> {
        return Observable.create { (observable) -> Disposable in
            if self.isSuccess {
                observable.onNext(self.books)
            } else {
                observable.onError(self.error)
            }
            return Disposables.create()
        }
    }
}
