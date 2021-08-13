//
//  HomePresenter.swift
//  UserListApp
//
//  Created by Baran Güngör on 13.08.2021.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
  func didFetchData(_ result: Result<[Person], Error>)
}

class HomePresenter {
  
  weak var delegate: HomePresenterDelegate?
  private var next: String? = nil
  private var dataSource: [Person] = []
  
  func fetchData(_ next: String? = nil) {
    DataSource.fetch(next: next) { [weak self] response, error in
      
      guard let self = self else { return }
      
      if let error = error {
        self.delegate?.didFetchData(.failure(error))
        return
      }
      
      self.configureDataSource(response?.people)
      self.delegate?.didFetchData(.success(self.dataSource))
    }
  }
  
  private func configureDataSource(_ people: [Person]?) {
    people?.forEach({
      dataSource.append($0)
    })
  }
  
}
