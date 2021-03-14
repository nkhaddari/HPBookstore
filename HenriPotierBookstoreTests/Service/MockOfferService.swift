//
//  MockOfferService.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 13/03/2021.
//

import Foundation
import RxSwift
@testable import HenriPotierBookstore

final class MockOfferService: OfferServiceProtocol {
    var offers: Offers
    var error: APIError
    var isSuccess: Bool
    
    init(offers: [Offer] = Offer.offersMock(),
         error: APIError = .decode,
         success: Bool = true) {
        self.offers = Offers(offers: offers)
        self.error = error
        self.isSuccess = success
    }
    
    func request(from endpoint: BooksApi) -> Observable<Offers> {
        return Observable.create { (observable) -> Disposable in
            if self.isSuccess {
                observable.onNext(self.offers)
            } else {
                observable.onError(self.error)
            }
            return Disposables.create()
        }
    }
}
