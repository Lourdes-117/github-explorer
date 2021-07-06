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
    
// MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        noResultsView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
    }

// MARK: Button Actions
    @IBAction func onTapAddNewRepo(_ sender: Any) {
    }
}

// MARK: TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {
    
}
