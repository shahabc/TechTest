//
//  WishListTableViewCell.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    private let productImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let quantityLabel = UILabel()
    private let disclosureImageView = UIImageView()
    private let colorView = ColorsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        // Custom Shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.07
        self.layer.shadowRadius = 1.0
    }
    
    private func setupViews() {
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        // Setup Main Stack View
        let contentStack = UIStackView()
        contentStack.axis = .horizontal
        contentStack.alignment = .center
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.spacing = 15
        
        
        //
        self.colorView.configureView(colors: ["#BED3F3"])
        
        // Setup Label Stack View
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.spacing = 2
        
        labelStack.addArrangedSubview(self.priceLabel)
        labelStack.addArrangedSubview(self.nameLabel)
        labelStack.addArrangedSubview(self.descriptionLabel)
        labelStack.addArrangedSubview(self.quantityLabel)
        labelStack.addArrangedSubview(self.colorView)
        
        self.priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        self.nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 11)
        self.quantityLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        
        self.priceLabel.textColor = .gray
        self.nameLabel.textColor = .gray
        self.descriptionLabel.textColor = .gray
        self.quantityLabel.textColor = .red
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup Image View
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.productImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            self.productImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        self.productImageView.contentMode = .scaleAspectFill
        
        // Setup Disclosure Icon
        self.disclosureImageView.image = UIImage(named: "disclosure")
        self.disclosureImageView.contentMode = .scaleAspectFit
        
        self.disclosureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.disclosureImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 10),
            self.disclosureImageView.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        // setup Container view
        contentStack.addArrangedSubview(self.productImageView)
        contentStack.addArrangedSubview(labelStack)
        contentStack.addArrangedSubview(self.disclosureImageView)
        
        containerView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            contentStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            contentStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            contentStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(product: Product) {
        
        self.nameLabel.text = product.name
        self.priceLabel.text = "$ \(Int(product.price))"
        self.descriptionLabel.text = product.description
        self.productImageView.image = UIImage(named: product.image)
        self.quantityLabel.isHidden = product.quantity > 0
        self.quantityLabel.text = "Out of stock"
        
        self.colorView.configureView(colors: product.colors)
        self.layoutIfNeeded()
    }
    
}
