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
  let userText = UILabel().with({
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.textColor = .boneWhite
  })
    
  // MARK: Functions
  override func configureViews() {
    self.backgroundColor = .clear
    
    addSubview(userText)
    userText.fill(.all, with: 5)
  }
  
  func configure(_ person: Person?) {
    let id = String(describing: person?.id ?? 0)
    userText.text = (person?.fullName ?? "") + " " + id
  }
  
}
