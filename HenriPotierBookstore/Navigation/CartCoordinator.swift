//
//  CartCoordinator.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 09/03/2021.
//

import UIKit

final class CartCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController!
    private let books: [BookViewModel]
    var parentCoordinator: BooksCoordinator?
    
    init(navigationController: UINavigationController, books: [BookViewModel]) {
        self.navigationController = navigationController
        self.books = books
    }
    
    func start() {
        let cartVC = CartViewController.newSelfFromNib()
        let viewModel = CartViewModel(books: books)
        viewModel.coordinator = self
        cartVC.viewModel = viewModel
        
        self.navigationController.pushViewController(cartVC, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
