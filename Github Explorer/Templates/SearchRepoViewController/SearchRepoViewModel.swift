//
//  SearchRepoViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class SearchRepoViewModel {
    var searchResults: SearchDataModel?
    let searchCellHeight: CGFloat = 70
    
    var numberOfRows: Int {
        searchResults?.items?.count ?? 0
    }
    
    func getRepoAtIndex(_ index: Int) -> RepositoryModel? {
        searchResults?.items?[index]
    }
}