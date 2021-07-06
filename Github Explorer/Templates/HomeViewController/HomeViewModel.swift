//
//  HomeViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class HomeViewModel {
    var savedRepositories: [RepositoryModel]?
    let cellHeight: CGFloat = 70
    func refreshData() {
        var repoModel = [RepositoryModel]()
        do {
            guard let savedRepo = try PersistanceService.shared.context.fetch(RepositoryCoreData.fetchRequest()) as? [RepositoryCoreData] else { return }
            for eachRepo in savedRepo {
                let owner = RepoOwnerModel(login: eachRepo.ownerName,
                                           avatarUrl: eachRepo.ownerAvatarUrl,
                                           id: Int(eachRepo.ownerId))
                let repo = RepositoryModel(id: Int(eachRepo.id),
                                           name: eachRepo.name,
                                           owner: owner,
                                           repoDescription: eachRepo.repoDescription)
                repoModel.append(repo)
            }
        } catch {
            debugPrint("Error Getting Saved Data \(error)")
            return
        }
        savedRepositories = repoModel
    }
    
    var numberOfRows: Int {
        savedRepositories?.count ?? 0
    }
    
    var noResultsViewIsHidden: Bool {
        numberOfRows > 0
    }
    
    func getRepoAtIndex(_ index: Int) -> RepositoryModel? {
        savedRepositories?[index]
    }
}
