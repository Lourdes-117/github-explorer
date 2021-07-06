//
//  ViewController.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class HomeViewController: UIViewController {
// MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    
    let viewModel = HomeViewModel()
    
// MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        registerCells()
        viewModel.refreshData()
        noResultsView.isHidden = viewModel.noResultsViewIsHidden
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func registerCells() {
        let nib = UINib(nibName: RepoTableViewCell.kIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RepoTableViewCell.kIdentifier)
    }

// MARK: Button Actions
    @IBAction func onTapAddNewRepo(_ sender: Any) {
        guard let searchRepoViewController = SearchRepoViewController.initiateNC() else { return }
        (searchRepoViewController.viewControllers.first as? SearchRepoViewController)?.delegate = self
        self.present(searchRepoViewController, animated: true, completion: nil)
    }
}

// MARK: TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.kIdentifier) as? RepoTableViewCell,
              let repoItem = viewModel.getRepoAtIndex(indexPath.row) else { return UITableViewCell() }
        cell.configureCell(repoItem)
        return cell
    }
}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDescriptionViewController = RepoDescriptionViewController()
        repoDescriptionViewController.selectedRepo = viewModel.getRepoAtIndex(indexPath.row)
        repoDescriptionViewController.managedObject = viewModel.getManagedObjectAtIndex(indexPath.row)
        repoDescriptionViewController.repoDescriptionViewType = .viewRepo
        repoDescriptionViewController.delegate = self
        navigationController?.pushViewController(repoDescriptionViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: viewModel.deleteText) {[weak self] _,_,_ in
            guard let entryToDelete = self?.viewModel.getManagedObjectAtIndex(indexPath.row) else { return }
            self?.viewModel.deleteEntry(entryToDelete)
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.endUpdates()
            self?.noResultsView.isHidden = self?.viewModel.noResultsViewIsHidden ?? true
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: Database Updated Home View Delegate
extension HomeViewController: DatabaseUpdateHomeViewDelegate {
    func datebaseUpdated() {
        viewModel.refreshData()
        noResultsView.isHidden = viewModel.noResultsViewIsHidden
        tableView.reloadData()
    }
}
