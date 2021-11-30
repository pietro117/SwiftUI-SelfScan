//
//  Item.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import SwiftUI

//Item Model and Sample Data...

struct Item: Identifiable {
    
    var id = UUID().uuidString
    var productCode: String
    var title: String
    var subTitle: String
    var longText: String
    var price: Double
    //var priceFormatted: String = ""
    var rating: String
    var image: String
    var imageURL: String = ""
}



var items = [

    Item(productCode: "1", title: "Cabbage", subTitle: "Vegetables", longText: "Here  is some really lengthy text about this monumentally interesting product.  Did you know, for instance, blah blah etc.", price: 2.5, rating: "3.8", image: "cabbage", imageURL: "https://www.gardeningknowhow.com/wp-content/uploads/2020/03/primo-vantage-400x350.jpg"),
//    Item(productCode: "2", title: "Cherries", subTitle: "Fruit", longText: "", price: 3.5, rating: "3.8", image: "cherries"),
//    Item(productCode: "3", title: "Spring Onions", subTitle: "Vegetables",longText: "", price: 25, rating: "3.8", image: "springonions"),
//    Item(productCode: "4", title: "Chicken Pie", subTitle: "Ready Meals",longText: "", price: 25, rating: "3.8", image: "meal")

]
