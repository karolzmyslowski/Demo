//
//  BaseViewController.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 15/08/2021.
//

import UIKit

public class BaseViewController<BaseView: UIView>: UIViewController {
    var customView: BaseView {
        return view as! BaseView
    }
    public override func loadView() {
        view = BaseView()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentErrorAlert(error: Error) {
        AlertProvider.showErrorAlert(on: self, title: "Error", message: error.localizedDescription, okTitle: "OK")
    }
}
