//
//  HomeViewController.swift
//  UserListApp
//
//  Created by Baran Güngör on 12.08.2021.
//

import UIKit
import CaseSPM

class HomeViewController: UIViewController {
  
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
  
  private var presenter = HomePresenter()
  private var dataSource: [Person] = []

  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    presenter.delegate = self
    configureViews()
    
    presenter.fetchData()
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
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withClass: UserCollectionViewCell.self, for: indexPath)
    cell.configure(dataSource[indexPath.item])
    return cell
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 30)
  }
}

extension HomeViewController: HomePresenterDelegate {
  func didFetchData(_ result: Result<[Person], Error>) {
    switch result {
    case .success(let model):
      dataSource = model
      collectionView.reloadData()
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}
