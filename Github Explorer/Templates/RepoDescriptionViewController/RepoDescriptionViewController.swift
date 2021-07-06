//
//  RepoDescriptionViewController.swift
//  Github Explorer
//
//  Created by Lourdes on 7/6/21.
//

import UIKit
import CoreData

class RepoDescriptionViewController: UIViewController {
// MARK: Properties
    var profilePicImage: UIImageView!
    var userNameLabel: UILabel!
    var repoNameLabel: UILabel!
    var descriptionLabel: UILabel!
    var addToWatchlistButton: UIButton!
    
    var safeArea: UILayoutGuide!
    
    var selectedRepo: RepositoryModel?
    var managedObject: NSManagedObject?
    var repoDescriptionViewType: RepoDescriptionViewType = .addRepo
    
    let viewModel = RepoDescriptionViewModel()
    
    weak var delegate: DatabaseUpdateHomeViewDelegate?
    
// MARK: Lifecycle Methods
    override func viewDidLoad() {
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        viewModel.selectedRepo = selectedRepo
        viewModel.repoViewType = repoDescriptionViewType
        viewModel.managedObject = managedObject
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        setupProfilePictureView()
        setupUserNameView()
        setupRepoNameView()
        setupDescriptionView()
        setupAddToWatchlistView()
    }
    
    fileprivate func setupProfilePictureView() {
        profilePicImage = UIImageView()
        let topPadding: CGFloat = 12
        let widthRatio: CGFloat = 0.4
        view.addSubview(profilePicImage)
        profilePicImage.translatesAutoresizingMaskIntoConstraints = false
        profilePicImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topPadding).isActive = true
        profilePicImage.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: widthRatio).isActive = true
        profilePicImage.heightAnchor.constraint(equalTo: profilePicImage.widthAnchor).isActive = true
        profilePicImage.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        profilePicImage.setImageFromUrl(viewModel.profilePicUrl)
        profilePicImage.roundedCorners()
    }
    
    fileprivate func setupUserNameView() {
        userNameLabel = UILabel()
        let topPadding: CGFloat = 12
        view.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: profilePicImage.bottomAnchor, constant: topPadding).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userNameLabel.text = viewModel.userNameText
    }
    
    fileprivate func setupRepoNameView() {
        repoNameLabel = UILabel()
        let topPadding: CGFloat = 12
        view.addSubview(repoNameLabel)
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: topPadding).isActive = true
        repoNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        repoNameLabel.text = viewModel.repoNameText
    }
    
    fileprivate func setupDescriptionView() {
        descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 10
        descriptionLabel.textAlignment = .justified
        let topPadding: CGFloat = 12
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: topPadding).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        descriptionLabel.text = viewModel.descriptionText
    }
    
    fileprivate func setupAddToWatchlistView() {
        addToWatchlistButton = UIButton()
        let horizontalPadding: CGFloat = 8
        view.addSubview(addToWatchlistButton)
        addToWatchlistButton.addTarget(self, action: #selector(onTapAddToWatchlistButton), for: .touchDown)
        addToWatchlistButton.translatesAutoresizingMaskIntoConstraints = false
        addToWatchlistButton.setTitle(viewModel.bottomButtonTitle, for: .normal)
        addToWatchlistButton.setTitleColor(viewModel.bottomButtonColor, for: .normal)
        addToWatchlistButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        addToWatchlistButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding).isActive = true
        addToWatchlistButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: horizontalPadding).isActive = true
    }
    
// MARK: Button Tap Actions
    @objc fileprivate func onTapAddToWatchlistButton() {
        viewModel.bottomBarAction()
        delegate?.datebaseUpdated()
        switch viewModel.repoViewType {
        case .addRepo:
            self.dismiss(animated: true, completion: nil)
        case .viewRepo:
            navigationController?.popViewController(animated: true)
        }
    }
}
