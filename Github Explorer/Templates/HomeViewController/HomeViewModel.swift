//
//  HomeViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit
import CoreData

class HomeViewModel {
    var savedRepositories: [RepositoryModel]?
    let cellHeight: CGFloat = 70
    let deleteText = "Delete"
    func refreshData() {
        var repoModel = [RepositoryModel]()
        guard let savedRepo = getManagedObject() else { return }
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
        savedRepositories = repoModel
    }
    
    func getManagedObject()-> [RepositoryCoreData]? {
        do {
            let fetchRequest: NSFetchRequest<RepositoryCoreData> = RepositoryCoreData.fetchRequest()
            let sortByTime = NSSortDescriptor(key: "updatedTime", ascending: false)
            fetchRequest.sortDescriptors = [sortByTime]
            let savedRepo = try PersistanceService.shared.context.fetch(fetchRequest) 
            return savedRepo
        } catch {
            debugPrint("Error Getting Saved Data \(error)")
            return nil
        }
    }
    
    func getManagedObjectAtIndex(_ index: Int)-> RepositoryCoreData? {
        return getManagedObject()?[index]
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
    
    func deleteEntry(_ entryToDelete: RepositoryCoreData) {
        PersistanceService.shared.context.delete(entryToDelete)
        PersistanceService.shared.saveContext()
        refreshData()
    }
}
