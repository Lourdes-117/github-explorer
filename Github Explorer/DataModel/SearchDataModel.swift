//
//  SearchDataModel.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation
struct SearchDataModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    let totalCount: Int?
    let items: [RepositoryModel?]?
}

struct RepositoryModel: Decodable {
    let id: Int?
    let name: String?
    let owner: RepoOwnerModel?
    let description: String?
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
