//
//  BookCartCell.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 09/03/2021.
//

import UIKit

class BookCartCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    lazy var numberFormatter: NumberFormatter = {
        NumberFormatter()
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: BookViewModel) {
        self.countLabel.text = "\(viewModel.quantity)"
        self.titleLabel.text = viewModel.title
        self.bookImageView.kf.setImage(with: viewModel.cover)
        self.isbnLabel.text = viewModel.isbn
        self.priceLabel.text = numberFormatter.formatted(price: viewModel.price)
        countLabel.isHidden = viewModel.quantity == 0 ? true : false
    }
    
}
