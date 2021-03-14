//
//  CartViewModel.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 09/03/2021.
//

import Foundation
import RxSwift
import RxRelay

final class CartViewModel {
    private(set) var title = "list_title".localized
    let books: [BookViewModel]
    weak var coordinator: CartCoordinator?
    private let service: OfferServiceProtocol
    private(set) var discount: BehaviorRelay<String> = BehaviorRelay(value: "-")
    private(set) var discountPrice: BehaviorRelay<String> = BehaviorRelay(value: "-")
    private(set) var errorMessage: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    private let disposeBag = DisposeBag()
    lazy var numberFormatter: NumberFormatter = {
        NumberFormatter()
    }()
    
    init(books: [BookViewModel],
         service: OfferServiceProtocol = OfferService()) {
        self.books = books
        self.service = service
    }
    
    private var total: Double {
        return Double(books.reduce(0) {
            $0 + ($1.quantity * $1.price)
        })
    }
    
    var formattedTotal: String {
        numberFormatter.formatted(price: total)
    }
    
    func getOffers() {
        var isbnArray: [String] = []
        
        books.forEach { book in
            isbnArray.append(contentsOf: repeatElement(book.isbn, count: book.quantity))
        }
        service.request(from: .getBestOfferFor(books: isbnArray)).subscribe(onNext: { [weak self] offers in
            guard let self = self else { return }
            let amount = OfferDiscount.bestOffer(offers: offers.offers, for: self.total)
            self.discount.accept(self.numberFormatter.formatted(price: amount))
            self.discountPrice.accept(self.numberFormatter.formatted(price: self.total - amount))
        }, onError: { [weak self] (error) in
            self?.errorMessage.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
}
