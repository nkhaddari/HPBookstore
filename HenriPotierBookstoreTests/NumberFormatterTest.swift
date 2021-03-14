//
//  NumberFormatterTest.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 10/03/2021.
//

import XCTest
@testable import HenriPotierBookstore

class NumberFormatterTests: XCTestCase {
    
    func testformattedPriceInt() {
        XCTAssertEqual(NumberFormatter().formatted(price: 10)
                        .replacingOccurrences(of: "\u{A0}", with: " "), "10 €")
        XCTAssertEqual(NumberFormatter().formatted(price: 1500)
                        .replacingOccurrences(of: "\u{A0}", with: " ")
                        .replacingOccurrences(of: "\u{202F}", with: " "), "1 500 €")
    }

    func testformattedPriceDouble() {
        XCTAssertEqual(NumberFormatter().formatted(price: 10.0)
                        .replacingOccurrences(of: "\u{A0}", with: " "), "10,00 €")
        XCTAssertEqual(NumberFormatter().formatted(price: 1500.50)
                        .replacingOccurrences(of: "\u{A0}", with: " ")
                        .replacingOccurrences(of: "\u{202F}", with: " "), "1 500,50 €")
    }
}
