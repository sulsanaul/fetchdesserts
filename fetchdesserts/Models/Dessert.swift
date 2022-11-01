//
//  Dessert.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/18/22.
//

struct Desserts: Decodable {
    let meals: [Dessert]
}

struct Dessert: Decodable {
    let name: String?
    let thumbnailPath: String?
    let id: String?
    let instructions: String?
    var quantifiedIngredients: [(String, String?)] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailPath = "strMealThumb"
        case instructions = "strInstructions"
    }
    
    struct IndexedCodingKey: CodingKey {
        let stringValue: String
        let intValue: Int?

        init(stringValue: String) {
            self.stringValue = stringValue
            intValue = nil
        }

        init(intValue: Int) {
            stringValue = String(intValue)
            self.intValue = intValue
        }
    }
}

extension Dessert {
    init(from decoder: Decoder) throws {
        let dessertContainer = try decoder.container(keyedBy: CodingKeys.self)
        let indexedContainer = try decoder.container(keyedBy: IndexedCodingKey.self)
        
        self.id = try dessertContainer.decode(String.self, forKey: .id)
        self.name = try dessertContainer.decode(String.self, forKey: .name)
        self.thumbnailPath = try dessertContainer.decode(String.self, forKey: .thumbnailPath)
        self.instructions = try dessertContainer.decodeIfPresent(String.self, forKey: .instructions)
        
        // wrangle wack api response
        self.quantifiedIngredients = try (1...20).compactMap({ index in
            let ingredient = try indexedContainer.decodeIfPresentAndNonEmpty(
                String.self,
                forKey: IndexedCodingKey(stringValue: "strIngredient\(index)")
            )
            let measurement = try indexedContainer.decodeIfPresentAndNonEmpty(
                String.self,
                forKey: IndexedCodingKey(stringValue: "strMeasure\(index)")
            )
            
            return (ingredient, measurement) as? (String, String?)
        })
    }
}

