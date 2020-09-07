//
//  ProductCollectionView.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-06.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import UIKit

class ProductCollectionView: UICollectionView {
    
    private let width = 100
    private let height = 100

    init(frame: CGRect) {
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.scrollDirection = .horizontal
        
        super.init(frame: frame, collectionViewLayout: flowLayout)

        // Setup Collection View
        self.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
