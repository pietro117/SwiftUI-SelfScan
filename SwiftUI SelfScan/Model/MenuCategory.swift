//
//  MenuCategory.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 19/11/2021.
//

import SwiftUI

struct MenuCategory: Identifiable, Equatable {
    
    var id = UUID().uuidString
    var categoryCode: String
    var title: String
}


let menuCategories: [MenuCategory] = [

    MenuCategory(categoryCode: "GROC_BAKE",title: "Bakery"),
    MenuCategory(categoryCode: "GROC_CHILL",title: "Chilled"),
    MenuCategory(categoryCode: "GROC_DRINK",title: "Drinks"),
    MenuCategory(categoryCode: "GROC_HABA",title: "Beauty"),
    MenuCategory(categoryCode: "GROC_PRD",title: "Produce")
    
]

