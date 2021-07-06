//
//  IssuesOrPullRequestsTableViewCellViewModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

enum PullRequestStatus: String {
    case open = "open"
    case merged = "merged"
    case closed = "closed"
}

class IssuesOrPullRequestsTableViewCellViewModel {
    var cellType: PullOrIssueRequestType?
    var issuesOrPull: PullsOrIssuesModel?
    
    var issueOrPullNumberText: String {
        "\(cellType?.titleSingular ?? "") number: \(issuesOrPull?.number ?? 0)"
    }
    
    var pullRequestStatus: String? {
        issuesOrPull?.status
    }
    
    var statusColor: UIColor {
        guard let status = PullRequestStatus(rawValue: issuesOrPull?.status ?? "") else { return .clear }
        switch status {
        case .closed:
            return .systemRed
        case .open:
            return .systemGreen
        case .merged:
            return .systemPurple
        }
    }
    
    var pullStatusIsHidden: Bool {
        cellType == .issues
    }
    
    var profilePicUrl: String? {
        issuesOrPull?.user?.avatarUrl
    }
    
    var issueOrPullTitle: String? {
        guard let cellType = cellType else { return nil }
        return "\(cellType.titleSingular): \(issuesOrPull?.title ?? "")"
    }
    
    var issueOrPullCreator: String? {
        return "Created by: \(issuesOrPull?.user?.login ?? "")"
    }
}
