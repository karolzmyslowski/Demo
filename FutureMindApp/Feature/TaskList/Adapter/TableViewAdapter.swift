//
//  TableViewAdapter.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 31/08/2021.
//

import UIKit

protocol TableViewAdapterDelegate: AnyObject {
    func didSelect(at index: IndexPath)
}

typealias TableAdapterType = NSObject & UITableViewDataSource & UITableViewDelegate

class TableViewAdapter: TableAdapterType {
    
    weak var delegate: TableViewAdapterDelegate?
    
    var items: [DisplayableTask] = []
    
    public init(items: [DisplayableTask]) {
        self.items = items
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainCell = tableView.dequeueReusableCell() as MainCell
        guard let model = items[safe: indexPath.row] else { return UITableViewCell () }
        mainCell.adapt(model: model)

        return mainCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelect(at: indexPath)
    }
}
