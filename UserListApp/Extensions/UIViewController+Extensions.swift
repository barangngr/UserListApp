//
//  UIViewController+Extensions.swift
//  UserListApp
//
//  Created by Baran Güngör on 13.08.2021.
//

import UIKit

extension UIViewController {
  func showErrorController(with error: Error) {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
