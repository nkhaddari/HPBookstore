//
//  NimberFormatter+Extensions.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 05/03/2021.
//

import Foundation

extension NumberFormatter {
    func formatted(price: Int) -> String {
        locale = Locale(identifier: "fr_FR")
        currencySymbol = "€"
        numberStyle = .currency
        maximumFractionDigits = 0
        minimumIntegerDigits = 1
        return self.string(for: price) ?? ""
    }
    
    func formatted(price: Double) -> String {
        locale = Locale(identifier: "fr_FR")
        currencySymbol = "€"
        numberStyle = .currency
        maximumFractionDigits = 2
        minimumIntegerDigits = 1
        return self.string(for: price) ?? ""
    }
}
