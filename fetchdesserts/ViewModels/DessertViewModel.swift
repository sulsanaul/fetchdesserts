//
//  DessertDetailViewModel.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/20/22.
//

import Foundation

class DessertViewModel {
    private var dessert: Dessert
    
    init(dessert: Dessert) {
        self.dessert = dessert
    }
    
    var name: String? {
        dessert.name
    }
    var id: String? {
        dessert.id
    }
    var thumbnailPath: String? {
        dessert.thumbnailPath
    }
    var instructions: String? {
        dessert.instructions
    }
    
    /// A tuple of strings corresponding to an ingredient and optional measurement, respectively
    var quantifiedIngredients: [(String, String?)]? {
        dessert.quantifiedIngredients
    }
    
    func fetchRecipe(completionHandler: @escaping () -> Void,
                     completionQueue: DispatchQueue = .main) {
        guard let id = self.id else { return }
        
        DessertsClient.fetchRecipe(withID: id, completionQueue: completionQueue) { dessert, error in
            guard let dessert = dessert, error == nil else { return }
            self.dessert = dessert
            completionQueue.async { completionHandler() }
        }
    }
}
