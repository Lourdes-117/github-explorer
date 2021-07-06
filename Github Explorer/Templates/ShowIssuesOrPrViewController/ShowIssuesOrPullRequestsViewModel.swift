//
//  ShowIssuesOrPullRequestsViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

enum PullOrIssueRequestType {
    case issues
    case pullRequests
    
    var titlePlural: String {
        switch self {
        case .issues:
            return "Issues"
        case .pullRequests:
            return "Pull Requests"
        }
    }
    
    var titleSingular: String {
        switch self {
        case .issues:
            return "Issue"
        case .pullRequests:
            return "Pull Request"
        }
    }
}

class ShowIssuesOrPullRequestsViewModel {
    var pullOrIssues: [PullsOrIssuesModel]?
    var screenType: PullOrIssueRequestType?
    var repository: RepositoryModel?
    var title: String? {
        screenType?.titlePlural
    }
    
    func fetchData(completion: @escaping () -> Void) {
        guard let screenType = screenType else { return }
        var url: String?
        switch screenType {
        case .issues:
            url = repository?.issuesUrl
        case .pullRequests:
            url = repository?.pullsUrl
        }
        guard let url = url else { return }
        NetworkManager.getDataFromApi(fromUrl: url) { [weak self] (pullsOrIssuesFromApi: [PullsOrIssuesModel]?) in
            self?.pullOrIssues = pullsOrIssuesFromApi
            completion()
        }
    }
    
    var numberOfRows: Int {
        (pullOrIssues?.count ?? 0)
    }
    
    func getIssueOrPullAtIndex(_ index: Int) -> PullsOrIssuesModel? {
        return pullOrIssues?[index]
    }
    
    func getUrlAtIndexpath(_ index: Int) -> URL? {
        guard let url = getIssueOrPullAtIndex(index)?.htmlUrl else { return nil }
        return URL(string: url)
    }
}
