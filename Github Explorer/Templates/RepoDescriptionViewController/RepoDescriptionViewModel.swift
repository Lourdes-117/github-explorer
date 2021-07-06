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
    
    var id: Int {
        selectedRepo?.id ?? 0
    }
    
    var userName: String? {
        selectedRepo?.owner?.login
    }
    
    var name: String? {
        selectedRepo?.name
    }
    
    var profilePicUrl: String? {
        selectedRepo?.owner?.avatarUrl
    }
    
    var userNameText: String {
        "Username: \(userName ?? "")"
    }
    
    var repoNameText: String {
        "RepoName: \(name ?? "")"
    }
    
    func saveSelectedRepository() {
        let newRepo = RepositoryCoreData(context: PersistanceService.shared.context)
        newRepo.id = Int64(id)
        newRepo.name = name
        newRepo.repoDescription = descriptionText
        newRepo.ownerName = selectedRepo?.owner?.login
        newRepo.ownerId = Int64(selectedRepo?.owner?.id ?? 0)
        newRepo.ownerAvatarUrl = selectedRepo?.owner?.avatarUrl
        PersistanceService.shared.saveContext()
    }
    
    var descriptionText: String? {
        selectedRepo?.repoDescription
    }
}
