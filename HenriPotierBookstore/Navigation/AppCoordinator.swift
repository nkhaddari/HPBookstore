//
//  AppCoordinator.swift
//  HPBookstore
//
//  Created by Nabil El khaddari on 04/03/2021.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        let navigationController = UINavigationController()
        let booksCoordinator = BooksCoordinator(navigationController: navigationController)
        childCoordinators.append(booksCoordinator)
        booksCoordinator.start()
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
