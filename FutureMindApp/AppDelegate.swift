//
//  AppDelegate.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    var serviceProvider: ServiceProviderProtocol = ServiceProvider()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        coordinator = MainCoordinator(navigationController: navigationController, serviceProvider: serviceProvider)
        coordinator?.goToMainView()
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

