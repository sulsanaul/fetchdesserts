//
//  DessertsClient.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/20/22.
//

import Foundation

class DessertsClient {
    typealias DessertsHandler = ([DessertViewModel]?, ClientError?) -> ()
    typealias RecipeHandler = (Dessert?, ClientError?) -> ()
    
    static func fetchDesserts(completionQueue: DispatchQueue = .main,
                              completionHandler: @escaping DessertsHandler) {
        guard let url = URL(string: Constants.dessertsPath) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("Client failed to fetch data.")
                completionQueue.async { completionHandler(nil, .failure) }
                return
            }
            do {
                // happy path (:
                let decoder = JSONDecoder()
                let dessertObjects = try decoder.decode(Desserts.self, from: data)
                let desserts = dessertObjects.meals.map(DessertViewModel.init)
                completionQueue.async { completionHandler(desserts, nil) }
            } catch {
                print("Failed with error: \(error.localizedDescription)")
                completionQueue.async { completionHandler(nil, .failure) }
            }
        }
        task.resume()
    }
    
    static func fetchRecipe(withID id: String,
                            completionQueue: DispatchQueue = .main,
                            completionHandler: @escaping RecipeHandler) {
        guard let url = URL(string: "\(Constants.recipePathPrefix)\(id)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("Client failed to fetch data.")
                completionQueue.async { completionHandler(nil, .failure) }
                return
            }
            do {
                // happy path (:
                let decoder = JSONDecoder()
                let dessertObject = try decoder.decode(Desserts.self, from: data)
                if let dessert = dessertObject.meals.first {
                    completionQueue.async { completionHandler(dessert, nil) }
                }
            } catch {
                print("Failed with error: \(error.localizedDescription)")
                completionQueue.async { completionHandler(nil, .failure) }
            }
        }
        task.resume()
    }
}

enum ClientError: Error {
    case failure
}
