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
    let login: String?
    let id: Int
}
