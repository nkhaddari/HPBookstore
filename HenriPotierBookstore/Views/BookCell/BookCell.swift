//
//  BookCell.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 05/03/2021.
//

import UIKit
import Kingfisher

class BookCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberOfBooksStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    var bookViewModel: BookViewModel!
    var numberOfBooksAction : ((_ value: Int, _ isbn: String) -> Void)?
    lazy var numberFormatter: NumberFormatter = {
        NumberFormatter()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: BookViewModel) {
        self.bookViewModel = viewModel
        self.titleLabel.text = self.bookViewModel.title
        self.bookImageView.kf.setImage(with: self.bookViewModel.cover)
        self.isbnLabel.text = self.bookViewModel.isbn
        self.priceLabel.text = self.numberFormatter.formatted(price: self.bookViewModel.price)
        self.numberOfBooksStepper.value = Double(self.bookViewModel.quantity)
        self.countLabel.text = "\(self.bookViewModel.quantity)"
        self.countLabel.isHidden = self.bookViewModel.quantity == 0 ? true : false
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfBooksAction?(Int(sender.value), bookViewModel.isbn)
    }
}
