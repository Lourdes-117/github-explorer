//
//  UIImageViewUtility.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

extension UIImageView {
    func setImageFromUrl(_ urlString: String?) {
        guard let url = urlString,
              let downloadUrl = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: downloadUrl)
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            } catch {
                debugPrint("Error Downloading Image \(error)")
            }
        }
    }
}
