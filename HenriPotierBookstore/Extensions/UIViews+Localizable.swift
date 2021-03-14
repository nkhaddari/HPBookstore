//
//  UIViews+Localizable.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 11/03/2021.
//

import UIKit

extension UILabel {
    @IBInspectable var localizedTitle: String {
        get { return "" }
        set {
            self.text = newValue.localized
        }
    }
}

extension UIButton {
    @IBInspectable var localizedTitle: String {
        get { return "" }
        set {
            self.setTitle(newValue.localized, for: .normal)
        }
    }
}
