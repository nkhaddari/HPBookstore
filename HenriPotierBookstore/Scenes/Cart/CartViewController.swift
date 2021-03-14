//
//  CartViewController.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 09/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController, Displaying {
    
    var viewModel: CartViewModel!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let cellIdentifier = "BookCartCell"
    
    lazy var offerView: UIView = {
        guard let view: OfferView = .fromNib() else {
            fatalError()
        }
        view.totalLabel.text = self.viewModel.formattedTotal
        self.viewModel.discount
            .asObservable().bind(to: view.discountLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.discountPrice
            .asObservable().bind(to: view.discountPriceLabel.rx.text).disposed(by: self.disposeBag)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        setupView()
        viewModel.getOffers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // if prefersLargeTitles set to false it  causes animation glitch
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func subscribe() {
        self.viewModel.errorMessage.compactMap { $0 }
            .asObservable().subscribe(onNext: { error in
                self.display(error: error)
            }).disposed(by: disposeBag)
    }
    
    func setupView() {
        self.title = viewModel.title
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = offerView
        
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? BookCartCell else {
            return UITableViewCell()
            
        }
        cell.configure(viewModel: viewModel.books[indexPath.row])
        return cell
    }
}
