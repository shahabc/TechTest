//
//  ViewModel.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Foundation

class ProductVM {
    
    var productsList: [Product] = []
    var wishList: [Product] = []
    
    func getProductList(url: String, completion: @escaping (_ success: Bool) -> Void) {
    
        if let path = Bundle.main.path(forResource: "Datasource", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            NetworkManager.requestData(url: url) { [weak self] result in
                
                guard let products = result["products"] as? [Any] else { return }
                self?.productsList = products.map({ Product(dict: ($0 as? [String: Any] ?? [:])) })
                completion(true)
            }
        }
        
        completion(false)
    }
}
