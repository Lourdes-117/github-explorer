//
//  RepoDescriptionViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation
import UIKit
import CoreData

protocol DatabaseUpdateHomeViewDelegate: AnyObject {
    func datebaseUpdated()
}

enum RepoDescriptionViewType {
    case addRepo
    case viewRepo
    
    var buttonTitle: String {
        switch self {
        case .addRepo:
            return "Add To Watchlist"
        case .viewRepo:
            return "Delete Repo"
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .addRepo:
            return .link
        case .viewRepo:
            return .systemRed
        }
    }
}

class RepoDescriptionViewModel {
    let showPullsText = "Show Pull Requests"
    let showaIssuesText = "Show Issues"
    let buttonColor: UIColor = .link
    var repoViewType: RepoDescriptionViewType = .addRepo
    var selectedRepo: RepositoryModel?
    var managedObject: NSManagedObject?
    var bottomButtonTitle: String {
        repoViewType.buttonTitle
    }
    var bottomButtonColor: UIColor {
        repoViewType.buttonColor
    }
    
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
    
    func bottomBarAction() {
        switch repoViewType {
        case .addRepo:
            let newRepo = RepositoryCoreData(context: PersistanceService.shared.context)
            newRepo.id = Int64(id)
            newRepo.name = name
            newRepo.repoDescription = descriptionText
            newRepo.ownerName = selectedRepo?.owner?.login
            newRepo.ownerId = Int64(selectedRepo?.owner?.id ?? 0)
            newRepo.ownerAvatarUrl = selectedRepo?.owner?.avatarUrl
            newRepo.updatedTime = Date()
        case .viewRepo:
            guard let managedObject = managedObject else { return }
            PersistanceService.shared.context.delete(managedObject)
        }
        PersistanceService.shared.saveContext()
    }
    
    var descriptionText: String? {
        selectedRepo?.repoDescription
    }
}
