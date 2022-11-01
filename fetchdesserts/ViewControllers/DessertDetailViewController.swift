//
//  DessertDetailViewController.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/18/22.
//

import UIKit
import Kingfisher

class DessertDetailViewController: UIViewController {
    var dessertViewModel: DessertViewModel
    
    lazy var imageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    lazy var containerStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.recipeViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var ingredientsTitleLabel = {
        let label = UILabel()
        label.text = Constants.ingredientsTitle
        label.font = Constants.recipeHeaderTwoFont
        return label
    }()
    
    lazy var instructionsTitleLabel = {
        let label = UILabel()
        label.text = Constants.instructionsTitle
        label.font = Constants.recipeHeaderTwoFont
        return label
    }()
    
    lazy var scrollView = UIScrollView()
    
    init(dessert: DessertViewModel) {
        self.dessertViewModel = dessert
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        title = dessertViewModel.name
        view.backgroundColor = .white
        view.addFullscreenSubview(scrollView)
        scrollView.addSubview(containerStackView)
        
        let constraints = [
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.recipeViewWidthProportion),
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        populateViewWithRecipeData()
    }
        
    func populateViewWithRecipeData() {
        dessertViewModel.fetchRecipe { [weak self] in
            guard let self = self else { return }
            
            if let thumbnailPath = self.dessertViewModel.thumbnailPath {
                let url = URL(string: thumbnailPath)
                self.imageView.kf.setImage(with: url)
                self.containerStackView.addArrangedSubview(self.imageView)
                self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor).isActive = true
            }
            
            guard let quantifiedIngredients = self.dessertViewModel.quantifiedIngredients else { return }
            self.containerStackView.addArrangedSubview(self.ingredientsTitleLabel)
            
            let ingredientLabels = quantifiedIngredients.map { (ingredient, measurement) in
                let label = UILabel()
                var text = ingredient
                if let measurement = measurement {
                    text = "\(measurement) \(ingredient)"
                }
                label.text = text
                return label
            }
            
            let ingredientsList = UIStackView(arrangedSubviews: ingredientLabels)
            ingredientsList.axis = .vertical
            self.containerStackView.addArrangedSubview(ingredientsList)
            
            if let instructions = self.dessertViewModel.instructions {
                let instructionsLabel = UILabel()
                self.scrollView.addSubview(instructionsLabel)
                
                instructionsLabel.text = instructions
                instructionsLabel.numberOfLines = 0
                instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
                
                self.containerStackView.addArrangedSubview(self.instructionsTitleLabel)
                self.containerStackView.addArrangedSubview(instructionsLabel)
            }
        }
    }
}
