//
//  ShowIssuesOrPullRequestsViewController.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class ShowIssuesOrPullRequestsViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var screenType: PullOrIssueRequestType?
    var repository: RepositoryModel?
    
    let viewModel = ShowIssuesOrPullRequestsViewModel()

// MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        registerCells()
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        viewModel.screenType = screenType
        viewModel.repository = repository
        self.title = viewModel.title
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.isHidden = true
                self?.loadingIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func registerCells() {
        let nib = UINib(nibName: IssuesOrPullRequestsTableViewCell.kIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: IssuesOrPullRequestsTableViewCell.kIdentifier)
    }
}

// MARK: - TableView Datasource
extension ShowIssuesOrPullRequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssuesOrPullRequestsTableViewCell.kIdentifier) as? IssuesOrPullRequestsTableViewCell,
              let cellType = viewModel.screenType,
              let pullOrIssue = viewModel.getIssueOrPullAtIndex(indexPath.row) else { return UITableViewCell() }
        cell.configureCell(cellType: cellType, issueOrPullModel: pullOrIssue)
        return cell
    }
}

// MARK: - TableView Delegate
extension ShowIssuesOrPullRequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
