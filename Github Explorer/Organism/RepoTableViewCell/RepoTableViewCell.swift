//
//  RepoTableViewCell.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    static let kIdentifier = "RepoTableViewCell"
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    func configureCell(_ repoItem: RepositoryModel) {
        usernameLabel.text = repoItem.owner?.login
        repoNameLabel.text = repoItem.name
        profilePictureView.roundedCorners()
        profilePictureView.setImageFromUrl(repoItem.owner?.avatarUrl)
    }
}
