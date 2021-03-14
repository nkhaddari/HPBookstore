//
//  OfferDiscountTest.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 10/03/2021.
//

import XCTest

@testable import HenriPotierBookstore

class OfferDiscountTest: XCTestCase {
    var total: Double!
    var offer: Offer!

    override func setUp() {
        super.setUp()
        total = 194
    }
    
    override func tearDown() {
        total = 0
        super.tearDown()
    }
    
    func testPercentage() {
        offer = Offer(type: .percentage, value: 8, sliceValue: nil)
        XCTAssertEqual(OfferDiscount.percentage(total, value: offer.value), 15.52)
    }
    
    func testMinus() {
        offer = Offer(type: .minus, value: 30, sliceValue: nil)
        XCTAssertEqual(OfferDiscount.minus(with: total, value: offer.value), 30)
    }
    
    func testSlice() {
        offer = Offer(type: .slice, value: 8, sliceValue: 80)
        XCTAssertEqual(OfferDiscount.slice(with: total, sliceValue: offer.sliceValue!, value: offer.value), 12.8)
    }
    
    func testBestOffer() {
        let offers = [ Offer(type: .percentage, value: 8, sliceValue: nil),
                       Offer(type: .minus, value: 30, sliceValue: nil),
                       Offer(type: .slice, value: 8, sliceValue: 80)]
        XCTAssertEqual(OfferDiscount.bestOffer(offers: offers, for: total), 30)
    }
}
