//
//  TaskListViewController.swift
//  FutureMindApp
//
//  Created by karol zmyslowski on 16/08/2021.
//

import UIKit
import SafariServices

final class TaskListViewController: BaseViewController<TaskListView> {
    
    var viewModel: TaskListViewModelProtocol
    
    init(viewModel: TaskListViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.adapter.delegate = self
        customView.tableView.setAdapter(viewModel.adapter)
        
        viewModel.fetchTasks { [weak self] error in
            guard let self = self else { return }
            if let error = error { self.presentErrorAlert(error: error); return }
            
            self.customView.reload()
        }
    }
}

// MARK: - TableViewAdapterDelegate
extension TaskListViewController: TableViewAdapterDelegate {
    func didSelect(at index: IndexPath) {
        guard let url = viewModel.selectedTaskURL(for: index.row) else { return }
        operSafari(with: url)
    }
}

// MARK: - Safari
extension TaskListViewController {
    func operSafari(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
    }
}
