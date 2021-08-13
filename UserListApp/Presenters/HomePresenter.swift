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
  
  // MARK: Functions
  func fetchData() {
    DataSource.fetch(next: next) { [weak self] response, error in
      
      guard let self = self else { return }
      
      if let error = error {
        self.delegate?.didFetchData(.failure(error))
        return
      }
      self.next = response?.next
      self.configureDataSource(response?.people)
      self.delegate?.didFetchData(.success(self.dataSource))
    }
  }
  
  func refreshData() {
    dataSource.removeAll()
    next = nil
    fetchData()
  }
  
  private func configureDataSource(_ people: [Person]?) {
    for person in people! {
      if !dataSource.contains(person) {
        dataSource.append(person)
      }
    }
  }
  
}

// MARK: - Extension
extension Person: Equatable {
  public static func ==(lhs: Person, rhs: Person) -> Bool {
      return lhs.id == rhs.id
  }
}
