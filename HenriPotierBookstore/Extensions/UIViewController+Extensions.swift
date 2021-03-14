//
//  UIViewController+Extensions.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import UIKit

extension UIViewController {
    
    static func newSelfFromNib() -> Self {
        let nibName = String(describing: self)
        return self.init(nibName: nibName, bundle: nil)
    }
}

protocol Displaying {
    func display(error message: String)
}

extension Displaying where Self: UIViewController {
    func display(error message: String) {
        let alertView  = UIAlertController(title: "",
                                           message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "done_button".localized, style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
}
