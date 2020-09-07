//
//  WishListHeaderView.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-07.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Foundation
import UIKit

class WishListHeaderView: UIView {
    
    private let headerNameLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.tableViewBackgroundColor
        
        self.headerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerNameLabel)
        self.addSubview(self.priceLabel)
        
        NSLayoutConstraint.activate([
            self.headerNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.headerNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.priceLabel.centerYAnchor.constraint(equalTo: self.headerNameLabel.centerYAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.headerNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        self.headerNameLabel.text = "Your wish list"
        self.headerNameLabel.font = UIFont.systemFont(ofSize: 12)
        self.priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(price: String) {
        self.priceLabel.text = price
    }
}
