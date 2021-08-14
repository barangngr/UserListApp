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
    cv.backgroundColor = .clear
    return cv
  }()
  
  private var refreshControl = UIRefreshControl().with({
    $0.tintColor = .cardinal
  })
  
  private var presenter = HomePresenter()
  private var dataSource: [Person] = []

  // MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .merlin
    presenter.delegate = self
    configureViews()
    configureCollectionView()
    
    presenter.fetchData()
  }
  
  // MARK: Functions
  private func configureViews() {
    view.addSubview(collectionView)
    collectionView.fill(.horizontally, with: 5)
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(handleRefreshControl(_:)), for: .valueChanged)
  }
  
  // MARK: Actions
  @objc private func handleRefreshControl(_ refreshControl: UIRefreshControl) {
    presenter.refreshData()
  }
  
}

// MARK: - Extensions
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataSource.count == 0 ? collectionView.setEmptyMessage("Nothing to show :(") : collectionView.restore()
    return dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withClass: UserCollectionViewCell.self, for: indexPath)
    cell.configure(dataSource[indexPath.item])
    return cell
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let endScrolling = (scrollView.contentOffset.y + scrollView.frame.size.height)
    if endScrolling >= scrollView.contentSize.height && endScrolling >= scrollView.frame.size.height {
      presenter.fetchData()
    }
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 40)
  }
}

extension HomeViewController: HomePresenterDelegate {
  func didFetchData(_ result: Result<[Person], Error>) {
    refreshControl.endRefreshing()
    switch result {
    case .success(let model):
      dataSource = model
      collectionView.reloadData()
    case .failure(let error):
      showErrorController(with: error)
    }
  }
}
