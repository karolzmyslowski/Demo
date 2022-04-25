//
//  MainCoordinator.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set}
    var navigationController: UINavigationController { get set }
    var serviceProvider: ServiceProviderProtocol { get }
    
    func goToMainView()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let serviceProvider: ServiceProviderProtocol
    
    init(navigationController: UINavigationController, serviceProvider: ServiceProviderProtocol) {
        self.navigationController = navigationController
        self.serviceProvider = serviceProvider
    }
    
    func goToMainView() {
        let viewModel = TaskListViewModel(serviceProvider: serviceProvider)
        let viewController = TaskListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
