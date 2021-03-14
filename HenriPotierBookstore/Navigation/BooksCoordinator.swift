//
//  BooksCoordinator.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import UIKit

final class BooksCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let booksVC = BooksViewController.newSelfFromNib()
        let viewModel = BooksViewModel()
        viewModel.coordinator = self
        booksVC.viewModel = viewModel
        self.navigationController.setViewControllers([booksVC], animated: false)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator-> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func goToCartWith(books: [BookViewModel]) {
        let cartCoordinator = CartCoordinator(navigationController: self.navigationController,
                                              books: books)
        cartCoordinator.parentCoordinator = self
        childCoordinators.append(cartCoordinator)
        cartCoordinator.start()
    }
}
