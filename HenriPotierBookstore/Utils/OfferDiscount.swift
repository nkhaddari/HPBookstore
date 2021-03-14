//
//  OfferDiscount.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 09/03/2021.
//

import Foundation

struct OfferDiscount {
    /**
        Get the best offer for an amount
    
    - parameter offers: the list of possible offers
    - parameter total: the total cost of books
    - returns: the best discount
    */
    static func bestOffer(offers: [Offer], for total: Double) -> Double {
        var discount: Double = 0.0
        offers.forEach { offer in
            switch offer.type {
            case .minus:
                let minus = OfferDiscount.minus(with: total, value: offer.value)
                discount = discount > minus ? discount : minus
            case .percentage:
                let percentage = OfferDiscount.percentage(total, value: offer.value)
                discount = discount > percentage ? discount : percentage
            case .slice:
                guard let sliceValue = offer.sliceValue else { return }
                let slice = OfferDiscount.slice(with: total, sliceValue: sliceValue, value: offer.value)
                discount = discount > slice ? discount : slice
            }
        }
        return discount
    }
    
    /**
        Apply the value of offer by percentage
    
    - parameter total: the total cost of books
    - parameter value: the value of the percentage
    - returns: discount amount
    */
    static func percentage(_ total: Double, value: Int) -> Double {
        return  (total * Double(value) / 100)
    }
    /**
        Apply the value of offer by minus
    
    - parameter total: the total cost of books
    - parameter value: the value of amount to be subtracted
    - returns: discount amount
    */
    static func minus(with total: Double, value: Int) -> Double {
        return Double(value)
    }
    /**
        Apply the percentage of offer by slice
    
    - parameter total: the total cost of books
    - parameter sliceValue: the value of every slice
    - parameter value: the value of the percentage
    - returns: discount amount
    */
    static func slice(with total: Double, sliceValue: Int, value: Int) -> Double {
        var minus = 0.0
        if total >= Double(sliceValue) {
            let times = total / Double(sliceValue)
            minus = times.rounded(.down) * Double(value) * Double(sliceValue) / 100
        }
        return minus
    }
}
