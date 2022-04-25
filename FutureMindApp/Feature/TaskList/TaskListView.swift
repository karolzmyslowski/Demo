//
//  TaskListView.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import UIKit

class TaskListView: UIView {
    
    @UsesAutoLayout
    var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.bounces = false
        $0.rowHeight = UITableView.automaticDimension
        $0.registerCellClasses([MainCell.self])
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func addSubviews() {
        [tableView].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        tableViewSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        setupSubviews()
    }
    
    private func tableViewSetup() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
