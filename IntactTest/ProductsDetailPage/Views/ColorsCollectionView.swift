//
//  ColorsCollectionView.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-07.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Foundation
import UIKit

class ColorsView: UIView {
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var colors: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 50, height: 50)
        flowLayout.scrollDirection = .horizontal
        
        // Setup Collection View
        
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.collectionView)
        
        self.collectionView.register(ColorsCell.self, forCellWithReuseIdentifier: "Colorcell")
        self.collectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(colors: [String]) {
        self.colors = colors
        self.collectionView.reloadData()
    }
}

extension ColorsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Colorcell", for: indexPath) as? ColorsCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.init(hexString: self.colors[indexPath.row])
        return cell
    }
}

class ColorsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
