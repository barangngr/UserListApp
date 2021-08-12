//
//  ViewController.swift
//  UserListApp
//
//  Created by Baran Güngör on 12.08.2021.
//

import UIKit
import CaseSPM

class ViewController: UIViewController {
  
  // MARK: Properties
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 5
    layout.minimumInteritemSpacing = 5
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(cellWithClass: UserCollectionViewCell.self)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.showsVerticalScrollIndicator = false
    cv.backgroundColor = .clear
    return cv
  }()

  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    configureViews()
  }
  
  // MARK: Functions
  private func configureViews() {
    view.addSubview(collectionView)
    collectionView.fill(.horizontally, with: 20)
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
}

// MARK: - Extensions
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 13
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withClass: UserCollectionViewCell.self, for: indexPath)
    cell.configure("123123")
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 20)
  }
}
