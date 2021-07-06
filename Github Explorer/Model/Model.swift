//
//  SearchDataModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation
import CoreData

struct SearchDataModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    let totalCount: Int?
    let items: [RepositoryModel?]?
}

struct RepositoryModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case repoDescription = "description"
    }
    let id: Int?
    let name: String?
    let owner: RepoOwnerModel?
    let repoDescription: String?
    
    var pullsUrl: String {
        String(format: StringConstants.shared.urls.pullsBaseUrl, owner?.login ?? "", name ?? "").addPercentEncoding()
    }
    
    var issuesUrl: String {
        String(format: StringConstants.shared.urls.issuesBaseUrl, owner?.login ?? "", name ?? "").addPercentEncoding()
    }
}

struct RepoOwnerModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case id
    }
    let login: String?
    let avatarUrl: String?
    let id: Int
}

struct PullsOrIssuesModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case number
        case url
        case status = "state"
        case title
        case user
    }
    let id: Int?
    let number: Int?
    let url: String?
    let status: String?
    let title: String?
    let user: RepoOwnerModel?
}
