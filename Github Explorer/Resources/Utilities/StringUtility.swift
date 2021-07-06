//
//  StringUtility.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import Foundation
extension String {
    func addPercentEncoding() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
