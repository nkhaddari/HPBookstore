//
//  BooksViewController.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class BooksViewController: UIViewController, Displaying {
    
    private let cellIdentifier = "BookCell"
    var viewModel: BooksViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var cartButton: UIBarButtonItem =  {
        var button = UIBarButtonItem()
        button.tintColor = .systemGray
        button.target = self
        button.action = #selector(onCartTapped)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        subscribe()
        bind()
        viewModel.getBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupView() {
        self.title = viewModel.title
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil),
                           forCellReuseIdentifier: cellIdentifier)
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    func subscribe() {
        // display the number of selected books
        viewModel.books.asObservable().subscribe(onNext: { books in
            let count = books.reduce(0) {
                $0 + $1.quantity
            }
            self.cartButton.title = "\(count) \u{1F6D2}"
        }).disposed(by: disposeBag)
        //present error in alertController
        self.viewModel.errorMessage.compactMap { $0 }
            .asObservable().subscribe(onNext: { error in
            self.display(error: error)
        }).disposed(by: disposeBag)
    }
    
    func bind() {
        // Bind the tableview to books
        viewModel.books.subscribe(on: MainScheduler.instance)
            .bind(to: tableView.rx
                    .items(cellIdentifier: cellIdentifier, cellType: BookCell.self)) { [weak self] index, viewModel, cell in
                guard let self = self else { return }
                cell.configure(viewModel: viewModel)
                // update number of books
                cell.numberOfBooksAction = { [weak self]  value, isbn in
                    self?.viewModel.didChangeNumberOfBookItem(at: isbn, with: value)
                }
        }.disposed(by: disposeBag)
    
    }
    
    @IBAction func onCartTapped() {
        self.viewModel.onGoToCart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
