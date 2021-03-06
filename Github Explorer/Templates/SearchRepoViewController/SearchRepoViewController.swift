//
//  SearchRepoViewController.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class SearchRepoViewController: UIViewController {
// MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = SearchRepoViewModel()
    
    weak var delegate: DatabaseUpdateHomeViewDelegate?
    
// MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        noResultsView.isHidden = true
        registerCells()
        self.title = viewModel.pageTitle
        activityIndicator.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    fileprivate func registerCells() {
        let nib = UINib(nibName: RepoTableViewCell.kIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RepoTableViewCell.kIdentifier)
    }
}

// MARK: TableView DataSource
extension SearchRepoViewController: UITableViewDataSource {
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
extension SearchRepoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDescriptionViewController = RepoDescriptionViewController()
        repoDescriptionViewController.selectedRepo = viewModel.getRepoAtIndex(indexPath.row)
        repoDescriptionViewController.delegate = delegate
        self.navigationController?.pushViewController(repoDescriptionViewController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        noResultsView.isHidden = true
    }
}

// MARK: SearchBar Delegate
extension SearchRepoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        searchBar.searchTextField.isEnabled = false
        guard let searchKey = searchBar.text,
              !searchKey.isEmpty else { return }
        let searchQuery = StringConstants.shared.urls.searchBaseUrl.appending(searchKey).addPercentEncoding()
        NetworkManager.getDataFromApi(fromUrl: searchQuery) { [weak self] (searchResults: SearchDataModel?) in
            self?.viewModel.searchResults = searchResults
            DispatchQueue.main.async {
                self?.noResultsView.isHidden = self?.viewModel.shouldHideNoResultsView ?? false
                searchBar.searchTextField.isEnabled = true
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
}
