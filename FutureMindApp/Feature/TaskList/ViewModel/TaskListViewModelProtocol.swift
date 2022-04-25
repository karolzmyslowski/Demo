//
//  TaskListViewModelProtocol.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

protocol TaskListViewModelProtocol {
    var adapter: TableViewAdapter { get }
    func fetchTasks(completion: @escaping ((Error?) -> ()))
    func selectedTaskURL(for index: Int) -> URL?
}
