//
//  UIViewControllerUtility.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

extension UIViewController {
    /// - Precondition: Both the custom VC class name and it's storyboard name should be same
    static func initiateVC() -> Self? {
        let storyBoard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: self)) as? Self
    }
    
    static func initiateNC() -> UINavigationController? {
        let storyBoard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)

        return storyBoard.instantiateInitialViewController() as? UINavigationController
    }
}
