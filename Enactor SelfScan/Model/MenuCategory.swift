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

    MenuCategory(categoryCode: "groc_bake",title: "Bakery"),
    MenuCategory(categoryCode: "groc_prd",title: "Produce"),
    MenuCategory(categoryCode: "groc_chill",title: "Chilled"),
    MenuCategory(categoryCode: "groc_drink",title: "Drinks"),
    MenuCategory(categoryCode: "groc_haba",title: "Beauty")
    
]
