//
//  ProductCardView.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Foundation
import UIKit


class ProductCardView: UIView {
    
    private let priceLabel = UILabel()
    private let freeShippingLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let colorTitleLabel = UILabel()
    private let heightLabel = UILabel()
    private let widthLabel = UILabel()
    private let depthLabel = UILabel()
    private let addProductButton = UIButton()
    private let colorCollection = ColorsView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        
        // Custom Shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowOpacity = 0.07
        self.layer.shadowRadius = 1.0
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setup Views
    
    private func setupView() {
        
        // Setup Price
        let priceStackView = UIStackView()
        priceStackView.addArrangedSubview(self.priceLabel)
        priceStackView.addArrangedSubview(self.freeShippingLabel)
        priceStackView.axis = .horizontal
        priceStackView.distribution = .fillProportionally
        priceStackView.alignment = .center
        
        self.addSubview(priceStackView)
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            priceStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            priceStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        self.priceLabel.font = UIFont.systemFont(ofSize: 30)
        
        self.freeShippingLabel.text = "Free Shipping World Wide"
        self.freeShippingLabel.font = UIFont.systemFont(ofSize: 14)
        self.freeShippingLabel.textColor = Colors.freeshipping
        
        // Setup Description
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.descriptionLabel.topAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        // Setup Size
        let sizeStackView = UIStackView()
        sizeStackView.axis = .horizontal
        sizeStackView.alignment = .top
        sizeStackView.distribution = .fillProportionally
        sizeStackView.spacing = 15

        
        let dimensionStackView = UIStackView()
        dimensionStackView.addArrangedSubview(self.heightLabel)
        dimensionStackView.addArrangedSubview(self.widthLabel)
        dimensionStackView.addArrangedSubview(self.depthLabel)
        dimensionStackView.axis = .vertical
        
        let sizeLabel = UILabel()
        sizeLabel.text = "Size"
        sizeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        sizeStackView.addArrangedSubview(sizeLabel)
        sizeStackView.addArrangedSubview(dimensionStackView)
        
        self.addSubview(sizeStackView)
        sizeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sizeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sizeStackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
            sizeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        // Setup Color section
        
        let colorStackView = UIStackView()
        colorStackView.axis = .horizontal
        colorStackView.alignment = .top
        colorStackView.distribution = .fill
        colorStackView.spacing = 15
        
        
        let colorLabel = UILabel()
        colorLabel.text = "Colors"
        colorLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        colorStackView.addArrangedSubview(colorLabel)
        colorStackView.addArrangedSubview(self.colorCollection)
        
        self.colorCollection.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(colorStackView)
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorStackView.topAnchor.constraint(equalTo: sizeStackView.bottomAnchor, constant: 20),
            colorStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            colorStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            colorStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -20),
            self.colorCollection.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func configureView(with product: Product) {
        self.priceLabel.text = "$ \(Int(product.price))"
        self.descriptionLabel.text = product.description
        self.heightLabel.text = "H: \(product.size.height) cm"
        self.widthLabel.text = "W: \(product.size.width) cm"
        self.depthLabel.text = "D: \(product.size.depth) cm"
        self.colorCollection.configureView(colors: product.colors)
    }
}
