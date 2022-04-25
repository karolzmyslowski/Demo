//
//  AlertProvider.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 01/09/2021.
//

import UIKit

class AlertProvider {
    
    @discardableResult
    static func showErrorAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        okTitle: String) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let ok = UIAlertAction(title: okTitle, style: .default)
        alert.addAction(ok)
        viewController.present(alert, animated: true)
        return alert
    }
    
}
