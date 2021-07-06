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
    
    let viewModel = SearchRepoViewModel()
    
// MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
}

// MARK: TableView DataSource
extension SearchRepoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

// MARK: TableView Delegate
extension SearchRepoViewController: UITableViewDelegate {
    
}

// MARK: SearchBar Delegate
extension SearchRepoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKey = searchBar.text,
              !searchKey.isEmpty else { return }
        let searchQuery = StringConstants.shared.urls.searchBaseUrl.appending(searchKey).addPercentEncoding()
        NetworkManager.getDataFromApi(fromUrl: searchQuery) { [weak self] (searchResults: SearchDataModel?) in
            self?.viewModel.searchResults = searchResults
        }
    }
}
