//
//  TaskListViewModel.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import Foundation

class TaskListViewModel: TaskListViewModelProtocol {
    
    lazy var adapter: TableViewAdapter = {
        let items = tasks.map { $0.makeDisplayableTask() }
        return TableViewAdapter(items: items)
    }()
    
    private let taskService: TaskService
    
    private var tasks: [Task] = [] {
        didSet { adapter.items = tasks.map { $0.makeDisplayableTask() } }
    }
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.taskService = serviceProvider.taskService
    }
    
    func fetchTasks(completion: @escaping ((Error?) -> ())) {
        taskService.getTasks { (result) in
            switch result {
            case .success(let tasks):
                self.tasks = tasks.sorted(by: { $0.orderId > $1.orderId })
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func selectedTaskURL(for index: Int) -> URL? {
        tasks[safe: index]?
            .description
            .findURL()
    }
}
