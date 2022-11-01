//
//  DessertTableViewCell.swift
//  fetchdesserts
//
//  Created by Sul S. on 10/19/22.
//

import UIKit

class DessertTableViewCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.dessertCellTitleFont
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    func configure(with dessert: DessertViewModel) {
        let stackView = UIStackView(arrangedSubviews: [thumbnail, nameLabel])
        nameLabel.text = dessert.name
        
        if let thumbnailPath = dessert.thumbnailPath {
            let url = URL(string: thumbnailPath)
            thumbnail.kf.setImage(with: url)
            thumbnail.kf.indicatorType = .activity
        }
        stackView.spacing = Constants.dessertCellSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets( Constants.dessertCellPadding)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addFullscreenSubview(stackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
}
