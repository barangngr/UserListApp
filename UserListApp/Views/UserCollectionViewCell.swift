//
//  UserCollectionViewCell.swift
//  UserListApp
//
//  Created by Baran Güngör on 12.08.2021.
//

import UIKit
import CaseSPM

class UserCollectionViewCell: BaseUICollectionViewCell {
  
  // MARK: Properties
  private let userText = UILabel().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .boneWhite
    $0.font = UIFont(name: "TrebuchetMS", size: 15)
  })
  
  private let separatorView = UIView().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .seperatorGrey
  })
    
  // MARK: Functions
  override func configureViews() {
    self.backgroundColor = .clear
    
    addSubview(views: userText, separatorView)
    userText.fill(.horizontally, with: 5)
    separatorView.fill(.horizontally, with: 5)
    
    userText.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
    userText.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -2).isActive = true
    
    separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
  }
  
  func configure(_ person: Person?) {
    guard let fullName = person?.fullName, let id = person?.id else { return }
    userText.text = fullName + " " + "(\(id))"
  }
  
}
