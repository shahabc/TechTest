//
//  ProductListVC.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController {
    
    private var collectionView = ProductCollectionView(frame: .zero)
    private let tableView = UITableView()
    
    private let productVM = ProductVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.title = "TASCH"
        
        productVM.getProductList(url: "") { success in
            if success {
                print("success")
                self.collectionView.reloadData()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
        self.tableView.reloadData()
        
    }

// MARK:- Setup Views
    
    private func setupViews() {
        
        self.view.backgroundColor = Colors.backgroundColor
        setupCollectionView()
        setupTableView()
        
    }
    
    private func setupCollectionView() {
        
        self.collectionView = ProductCollectionView(frame: self.view.frame)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        
        let collectionTitleLabel = UILabel()
        collectionTitleLabel.text = "Product catalogue"
        collectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionTitleLabel.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(collectionTitleLabel)
        
        NSLayoutConstraint.activate([
            collectionTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.collectionView.topAnchor.constraint(equalTo: collectionTitleLabel.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupTableView() {
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 20),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(WishListTableViewCell.self, forCellReuseIdentifier: "WishListCell")
        
        //Tableview Styling
        self.tableView.backgroundColor = Colors.tableViewBackgroundColor
        self.tableView.separatorStyle = .none
        
    }
    
    private func navigateToDetailView(product: Product, viewModel: ProductVM) {
        let detailVC = ProductDetailVC.init(product: product, viewModel: viewModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}

// MARK:- Collection View

extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productVM.productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
       
        let product = self.productVM.productsList[indexPath.row]
        
        cell.configureCell(name: product.name,
                           image: UIImage(named: product.image))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = self.productVM.productsList[indexPath.row]
        self.navigateToDetailView(product: product, viewModel: self.productVM)
    }
    
}

// MARK: - Table View

extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productVM.wishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishListCell", for: indexPath) as? WishListTableViewCell else {
            return UITableViewCell()
        }
        let product = self.productVM.wishList[indexPath.row]
        cell.configureCell(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = self.productVM.wishList[indexPath.row]
        self.navigateToDetailView(product: product, viewModel: self.productVM)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = WishListHeaderView()
        headerView.configureView(price: "Total $\(self.calculateSubTotal())")
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = WishListFooterView()
        
        let subtotal = self.calculateSubTotal()
        let isButtonHidden = subtotal == 0
        
        let callback = { [weak self] in
            let alertVC = UIAlertController(title: "", message: "Are you sure you want to proceed to checkout?", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                self?.productVM.wishList.removeAll()
                self?.tableView.reloadData()
            }))
            DispatchQueue.main.async {
                self?.present(alertVC, animated: true, completion: nil)
            }
        }
        
        footerView.configureView(price: "$\(subtotal)",isCheckoutBtnHidden: isButtonHidden, alertCallBack: callback)
        
        return footerView
    }
    
    private func calculateSubTotal() -> Int {
        return Int(self.productVM.wishList.map({ $0.price }).reduce(0, +))
    }
}

