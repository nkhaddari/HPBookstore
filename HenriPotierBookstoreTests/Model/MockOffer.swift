//
//  MockOffer.swift
//  HPBookstoreTests
//
//  Created by Nabil El khaddari on 13/03/2021.
//

import Foundation
@testable import HenriPotierBookstore

extension Offer {
    static func offersMock() -> [Offer] {
        let offers = [Offer(type: .minus, value: 9, sliceValue: nil),
                      Offer(type: .percentage, value: 8, sliceValue: nil),
                      Offer(type: .slice, value: 12, sliceValue: 40)]
        return offers
    }
}
