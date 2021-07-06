//
//  StringConstants.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation
struct StringConstants {
    private init() {}
    static let shared = StringConstants()
    
    let urls = ApiBaseUrls()
}

struct ApiBaseUrls {
    let searchBaseUrl = "https://api.github.com/search/repositories?q="
    let issuesBaseUrl = "https://api.github.com/repos/%@/%@/issues"
    let pullsBaseUrl = "https://api.github.com/repos/%@/%@/pulls"
}
