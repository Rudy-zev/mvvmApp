//
//  HomeCoordinator.swift
//  mvvmApp
//
//  Created by Bertrand BLOC'H on 26/10/2018.
//  Copyright © 2018 OPC. All rights reserved.
//

import UIKit

final class HomeCoordinator {

    // MARK: - Properties

    private let presenter: UIWindow

    private let navigationController: UINavigationController

    private let screens: Screens

    private let network: NetworkType
    
    // MARK: - Initializer

    init(presenter: UIWindow, network: NetworkType = Network()) {
        self.presenter = presenter
        self.network = network
        self.navigationController = UINavigationController(nibName: nil, bundle: nil)
        self.screens = Screens()
    }
    
    // MARK: - Coodinator

    func start() {
        presenter.rootViewController = navigationController
        showHome()
    }

    private func showHome() {
        let repository = HomeRepository(network: network)
        let viewController = screens.creatHomeViewController(repository: repository, delegate: self)
        navigationController.viewControllers = [viewController]
    }

    private func showDetails(for title: String) {
        let viewController = screens.createDetailsViewController(title: title)
        navigationController.show(viewController, sender: nil)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeScreenDidSelectDetail(with title: String) {
        showDetails(for: title)
    }
}
