//
//  TableView.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Identifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue table view cell with identifier \(T.identifier)")
        }
        
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: Identifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue table view cell with identifier \(T.identifier)")
        }
        
        return cell
    }
    
    func registerCellClasses(_ cellClasses: [Identifiable.Type]) {
        cellClasses.forEach { register($0, forCellReuseIdentifier: $0.identifier) }
    }
    
    func setAdapter(_ adapter: TableAdapterType) {
        dataSource = adapter
        delegate = adapter
    }
}
