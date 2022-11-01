//
//  Constants.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/19/22.
//

import UIKit

enum Constants {
    static let dessertCellHeight: CGFloat = 150.0
    static let dessertCellPadding: CGFloat = 20.0
    static let dessertCellSpacing: CGFloat = 20.0
    static let recipeViewWidthProportion: CGFloat = 0.85
    static let recipeViewSpacing: CGFloat = 20.0
    
    static let dessertsListViewTitle = "Desserts"
    static let ingredientsTitle = "Ingredients"
    static let instructionsTitle = "Instructions"
    
    static let dessertsPath = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let recipePathPrefix = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    
    static let dessertCellTitleFont = UIFont.systemFont(ofSize: 24.0, weight: .light)
    static let recipeHeaderTwoFont = UIFont.systemFont(ofSize: 24.0, weight: .medium)
}
