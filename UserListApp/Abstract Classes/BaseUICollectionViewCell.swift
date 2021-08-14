//
//  BaseUICollectionViewCell.swift
//  UserListApp
//
//  Created by Baran Güngör on 12.08.2021.
//

import UIKit

class BaseUICollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureViews()
  }
  
  func configureViews() {}
  
}
