//
//  String+Extensions.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import Foundation

extension String {
    var localized: String {
        let localizedString = NSLocalizedString(self, comment: "")
        if localizedString != self {
            return localizedString
        }
        return NSLocalizedString(self, tableName: "Extra", comment: "")
    }
}
