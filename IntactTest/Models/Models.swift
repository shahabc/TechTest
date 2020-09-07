//
//  Models.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Foundation


struct Product {
    let image: String
    let name: String
    let description: String
    let colors: [String]
    let size: Dimension
    let price: Double
    let quantity: Int
}

extension Product {
    init(dict: [String: Any]) {
        image = dict["image"] as? String ?? ""
        name = dict["name"] as? String ?? ""
        description = dict["description"] as? String ?? ""
        colors = dict["colors"] as? [String] ?? []
        size = dict["size"].map({ Dimension(dict: $0 as? [String: Any] ?? [:]) }) ?? .empty
        price = dict["price"] as? Double ?? 0.0
        quantity = dict["quantity"] as? Int ?? 0
    }
}

struct Dimension {
    let height: Int
    let width: Int
    let depth: Int
    
    static var empty: Dimension {
        .init(height: 0, width: 0, depth: 0)
    }
}

extension Dimension {
    
    init(dict: [String: Any]) {
        height = dict["height"] as? Int ?? 0
        width = dict["width"] as? Int ?? 0
        depth = dict["depth"] as? Int ?? 0
    }
}
