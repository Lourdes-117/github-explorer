//
//  IssuesOrPullRequestsTableViewCell.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit

class IssuesOrPullRequestsTableViewCell: UITableViewCell {
    @IBOutlet weak var issueOrPullNumber: UILabel!
    @IBOutlet weak var pullStatusView: UIView!
    @IBOutlet weak var pullStatus: UILabel!
    @IBOutlet weak var issueOrPullTitle: UILabel!
    @IBOutlet weak var issueOrPullCreator: UILabel!
    @IBOutlet weak var creatorImageView: UIImageView!
    
    static let kIdentifier = "IssuesOrPullRequestsTableViewCell"
    
    let viewModel = IssuesOrPullRequestsTableViewCellViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(cellType: PullOrIssueRequestType, issueOrPullModel: PullsOrIssuesModel) {
        viewModel.cellType = cellType
        viewModel.issuesOrPull = issueOrPullModel
        setupUI()
    }
    
    private func setupUI() {
        issueOrPullNumber.text = viewModel.issueOrPullNumberText
        pullStatusView.isHidden = viewModel.pullStatusIsHidden
        pullStatus.text = viewModel.pullRequestStatus
        pullStatus.textColor = viewModel.statusColor
        creatorImageView?.setImageFromUrl(viewModel.profilePicUrl)
        issueOrPullTitle.text = viewModel.issueOrPullTitle
        issueOrPullCreator.text = viewModel.issueOrPullCreator
        creatorImageView.roundedCorners()
    }
}
