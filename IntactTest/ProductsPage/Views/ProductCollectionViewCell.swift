//
//  ProductCollectionViewCell.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let nameLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        
        // Custom Shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.07
        self.layer.shadowRadius = 1.0
        
        // Setup View
        let stackview = UIStackView()
        stackview.addArrangedSubview(self.imageView)
        stackview.addArrangedSubview(self.nameLabel)
        stackview.alignment = .center
        stackview.axis = .vertical
        stackview.spacing = 2
        
        self.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // Image View setup
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.heightAnchor.constraint(equalToConstant: 60),
            self.imageView.widthAnchor.constraint(equalToConstant: 60)
            
        ])
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        self.nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.nameLabel.textColor = .gray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(name: String, image: UIImage?) {
        self.nameLabel.text = name
        self.imageView.image = image
    }
    
}
