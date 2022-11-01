//
//  DessertsViewModel.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/19/22.
//

import Foundation

class DessertsListViewModel {
    var desserts: [DessertViewModel] = []
    
    func fetchDesserts(completionHandler: @escaping () -> Void,
                       completionQueue: DispatchQueue = .main) {
        DessertsClient.fetchDesserts(completionQueue: completionQueue) { desserts, error in
            guard let desserts = desserts, error == nil else { return }
            self.desserts = desserts
            completionQueue.async { completionHandler() }
        }
    }
}
