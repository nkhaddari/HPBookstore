//
//  Offer.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation

struct Offers: Codable {
    let offers: [Offer]
}

// MARK: - Offer
struct Offer: Codable {
    let type: OfferType
    let value: Int
    let sliceValue: Int?
}
