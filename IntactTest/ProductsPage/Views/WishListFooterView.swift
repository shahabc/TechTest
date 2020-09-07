//
//  WishListFooterView.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-07.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Foundation
import UIKit

class WishListFooterView: UIView {
    
    private let checkoutButton = UIButton()
    private let subtotalLabel = UILabel()
    private let priceLabel = UILabel()
    private let shippingLabel = UILabel()
    private var alertCallBack: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.tableViewBackgroundColor
        
        // Pric Labels
        let priceStack = UIStackView()
        priceStack.addArrangedSubview(self.subtotalLabel)
        priceStack.addArrangedSubview(self.priceLabel)
        priceStack.axis = .horizontal
        priceStack.spacing = 2
        
        self.subtotalLabel.text = "Sub-total"
        self.subtotalLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        self.shippingLabel.text = "Free Shipping World Wide"
        self.shippingLabel.textColor = Colors.freeshipping
        self.shippingLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        self.priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        // Checkout Button
        self.checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.checkoutButton.backgroundColor = Colors.addButton
        self.checkoutButton.setTitle("Proceed To Checkout", for: .normal)
        self.checkoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.checkoutButton.layer.cornerRadius = 5
        
        let labelStack = UIStackView()
        labelStack.addArrangedSubview(priceStack)
        labelStack.addArrangedSubview(self.shippingLabel)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        labelStack.alignment = .center
        
        self.addSubview(labelStack)
        self.addSubview(self.checkoutButton)
        
        NSLayoutConstraint.activate([
            labelStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            labelStack.bottomAnchor.constraint(equalTo: self.checkoutButton.topAnchor, constant: -5),
            self.checkoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.checkoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.checkoutButton.widthAnchor.constraint(equalToConstant: 150),
            self.checkoutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.checkoutButton.addTarget(self, action: #selector(didTapCheckoutBtn), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(price: String, isCheckoutBtnHidden: Bool, alertCallBack: @escaping () -> Void) {
        self.subtotalLabel.text = price
        self.checkoutButton.isHidden = isCheckoutBtnHidden
        self.alertCallBack = alertCallBack
    }
    
    @objc
    func didTapCheckoutBtn(sender: UIButton) {
        self.alertCallBack()
    }
    
    
    
}
