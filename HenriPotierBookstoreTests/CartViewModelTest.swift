//
//  CartViewModelTest.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 13/03/2021.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking
@testable import HenriPotierBookstore

class CartViewModelTest: XCTestCase {
    var scheduler: ConcurrentDispatchQueueScheduler!
    var viewModel: CartViewModel!
    var mockOffersService: MockOfferService!
    lazy var numberFormatter: NumberFormatter = {
        NumberFormatter()
    }()
    
    override func setUp() {
        super.setUp()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    func testOfferSuccess() {
        mockOffersService = MockOfferService(offers: Offer.offersMock())
        viewModel = CartViewModel(books: BookViewModel.selectedBooksViewModelMock(),
                                  service: mockOffersService)
        let discountObservable = viewModel.discount.asObservable().subscribe(on: scheduler)
        let discountPriceObservable = viewModel.discountPrice.asObservable().subscribe(on: scheduler)
        viewModel.getOffers()
        do {
            guard let result = try discountObservable.toBlocking(timeout: 1.0).first() else {
                XCTFail("No data received")
                return
            }
            XCTAssertEqual(self.numberFormatter.formatted(price: 9.6), result)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            guard let result = try discountPriceObservable.toBlocking(timeout: 1.0).first() else {
                XCTFail("No data received")
                return
            }
            XCTAssertEqual(self.numberFormatter.formatted(price: 85.4), result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOfferFail() {
        mockOffersService = MockOfferService(offers: Offer.offersMock(),
                                             error: .errorCode(400), success: false)
        viewModel = CartViewModel(books: BookViewModel.selectedBooksViewModelMock(),
                                  service: mockOffersService)
        let errorObservable = viewModel.errorMessage.asObservable().subscribe(on: scheduler)
        viewModel.getOffers()
        
        do {
            guard let result = try errorObservable.toBlocking(timeout: 1.0).first() else {
                XCTFail("No data received")
                return
            }
            XCTAssertEqual(APIError.errorCode(400).errorDescription, result)
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
