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

    /* Grocery
    
    MenuCategory(categoryCode: "f_bakery",title: "Bakery"),
    MenuCategory(categoryCode: "f_chilled",title: "Chilled"),
    MenuCategory(categoryCode: "f_drinks",title: "Drinks"   ),
    MenuCategory(categoryCode: "f_haba",title: "Beauty")
     */

    // Drinks
    /*
    MenuCategory(categoryCode: "fd_wine",title: "Wine"),
    MenuCategory(categoryCode: "fd_beer",title: "Beer"),
    MenuCategory(categoryCode: "fd_spirits",title: "Sprits"),
    MenuCategory(categoryCode: "f_nonfood",title: "Misc")
     */
    
    //Chanel

//MenuCategory(categoryCode: "retail_w_bags",title: "Handbags"),
//MenuCategory(categoryCode: "retail_b_fragrance",title: "Fragrance"),
//MenuCategory(categoryCode: "retail_b_cosmetics",title: "Cosmetics"),
//MenuCategory(categoryCode: "retail_b_skincare",title: "Skincare"),
//MenuCategory(categoryCode: "retail_w_watches",title: "Watches"),
//MenuCategory(categoryCode: "retail_w_eyewear",title: "Eyewear")
//MenuCategory(categoryCode: "retail_w_dresses",title: "Ready to Wear")

    
    //DIY
//    MenuCategory(categoryCode: "gardens",title: "Garden"),
//    MenuCategory(categoryCode: "decoration",title: "Decoration"),
//    MenuCategory(categoryCode: "building",title: "Building\nMaterials"),
//    MenuCategory(categoryCode: "windows",title: "Windows")
    
    //Gift
    MenuCategory(categoryCode: "gifts",title: "Gifts"),
    MenuCategory(categoryCode: "cards",title: "Cards"),
    MenuCategory(categoryCode: "party",title: "Party"),
    MenuCategory(categoryCode: "halloween",title: "Halloween"),
    MenuCategory(categoryCode: "christmas",title: "Christmas")
]
