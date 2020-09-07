//
//  ProductDetailVC.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    private let imageView = UIImageView()
    private let cardDetailView = ProductCardView()
    private let addButton = UIButton()
    private var isAddedToWishList = false
    
    private let product: Product
    private let viewModel: ProductVM
    
    init(product: Product, viewModel: ProductVM) {
        self.product = product
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.backgroundColor
        self.title = product.name
        
        // Image View
        let imageContainer = UIView()
        
        self.view.addSubview(imageContainer)
        imageContainer.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        imageContainer.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 30),
            self.imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 15),
            self.imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -15),
            self.imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -30)
        ])
        
        self.imageView.image = UIImage(named: product.image)
        self.imageView.contentMode = .scaleAspectFit
        
        // Product Card
        self.view.addSubview(self.cardDetailView)
        self.cardDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.cardDetailView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -15),
            self.cardDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.cardDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
        ])
        
        self.cardDetailView.configureView(with: self.product)
        
        // Button
        
        self.view.addSubview(self.addButton)
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.addButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.addButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.addButton.topAnchor.constraint(equalTo: self.cardDetailView.bottomAnchor, constant: 20),
            self.addButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        self.addButton.layer.cornerRadius = 10
        self.addButton.addTarget(self, action: #selector(didTapOnAddButton), for: .touchUpInside)
        self.setupButton()
        
    }
    
    private func setupButton() {
        let product = self.viewModel.wishList.filter({ $0.name == self.product.name })
        self.isAddedToWishList = product.isEmpty ? false : true
        self.setupButtonStyle()
    }
    
    private func setupButtonStyle() {
        self.addButton.backgroundColor = isAddedToWishList ? .black : Colors.addButton
        self.addButton.setTitle( isAddedToWishList ? "Remove from wish list" : "Add to wish list", for: .normal)
        self.view.layoutIfNeeded()
    }
    
    @objc
    func didTapOnAddButton(sender: UIButton) {
        
        if self.isAddedToWishList {
            self.viewModel.wishList.removeAll(where: { $0.name == self.product.name })
            self.isAddedToWishList = false
        } else {
            self.viewModel.wishList.append(self.product)
            self.isAddedToWishList = true
        }
        self.setupButtonStyle()
    }
    
    
}
