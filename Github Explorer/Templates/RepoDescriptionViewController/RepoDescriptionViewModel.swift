//
//  RepoDescriptionViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation
class RepoDescriptionViewModel {
    var selectedRepo: RepositoryModel?
    let addToWatchlistButtonTitle = "Add to Watchlist"
    
    var profilePicUrl: String? {
        selectedRepo?.owner?.avatarUrl
    }
    
    var userNameText: String {
        "Username: \(selectedRepo?.owner?.login ?? "")"
    }
    
    var repoNameText: String {
        "RepoName: \(selectedRepo?.name ?? "")"
    }
    
    var descriptionText: String? {
        selectedRepo?.description
    }
}
