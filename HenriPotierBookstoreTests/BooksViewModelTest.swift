//
//  BooksViewModelTest.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 12/03/2021.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking
@testable import HenriPotierBookstore

class BooksViewModelTest: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!
    var viewModel: BooksViewModel!
    var mockBooksService: MockBookService!

    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    func testSucceededBooks() {
        mockBooksService = MockBookService(books: Book.booksMock())
        viewModel = BooksViewModel(service: mockBooksService)
        let booksVMObservable = viewModel.books.asObservable().subscribe(on: scheduler)
        viewModel.getBooks()
        do {
            guard let result = try booksVMObservable.toBlocking(timeout: 1.0).first() else {
                XCTFail("No data received")
                return
            }
            XCTAssertEqual(BookViewModel.booksViewModelMock(), result)
            XCTAssertEqual(result.first?.quantity, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testFailedBooks() {
        mockBooksService = MockBookService(books: Book.booksMock(),
                                           error: APIError.decode, success: false)
        viewModel = BooksViewModel(service: mockBooksService)
        let errorObservable = viewModel.errorMessage.asObservable().subscribe(on: scheduler)
        viewModel.getBooks()
        
        do {
            guard let result = try errorObservable.toBlocking(timeout: 1.0).first() else {
                XCTFail("No data received")
                return
            }
            XCTAssertEqual(APIError.decode.errorDescription, result)
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
