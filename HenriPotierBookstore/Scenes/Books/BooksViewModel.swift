//
//  BooksViewModel.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation
import RxSwift
import RxRelay

class BooksViewModel {
    
    private(set) var title = "list_title".localized
    private let service: BooksServiceProtocol
    weak var coordinator: BooksCoordinator?
    private(set) var books: BehaviorRelay<[BookViewModel]> = BehaviorRelay(value: [])
    private(set) var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    private let disposeBag = DisposeBag()
    
    init(service: BooksServiceProtocol = BooksService()) {
        self.service = service
    }
    
    func getBooks() {
        
        service.request(from: .getBooks).subscribe(onNext: { [weak self] books in
            let booksViewModel = books.map { BookViewModel(book: $0)}
            self?.books.accept(booksViewModel)
        }, onError: { [weak self] error in
            self?.errorMessage.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
        
    }
    
    func didChangeNumberOfBookItem(at isbn: String, with value: Int) {
        var booksVM = books.value
        booksVM = booksVM.map {
            var book = $0
            if book.isbn == isbn {
                book.quantity = value
                return book
            } else {
                return book
            }
        }
        
        self.books.accept(booksVM)
    }
    
    func onGoToCart() {
        let selectedBooks = books.value.filter { $0.quantity != 0 }
        if selectedBooks.count == 0 {
            self.errorMessage.accept("empty_cart".localized)
        } else {
            self.coordinator?.goToCartWith(books: selectedBooks)
        }
        
    }
}
