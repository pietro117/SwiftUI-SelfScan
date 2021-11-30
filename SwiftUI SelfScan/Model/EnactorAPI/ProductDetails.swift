//
//  ProductListItem.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import Foundation

struct ProductDetailsItem: Codable, Identifiable {
    let id = UUID()
    var productId: String = ""
    var description: String = ""
    var longDescription: String? = ""
    var price: NSInteger? = 0
    var productImageURL: String? = ""
    
    init(productId: String = "", description: String = "", longDescription: String? = "", price: NSInteger? = 0, productImageURL: String? = "") {
            self.productId = productId
            self.description = description
            self.longDescription = longDescription
            self.price = price
            self.productImageURL = productImageURL
        }
}

struct ProductSearchResponse: Codable, Identifiable {
    
    let id = UUID()
    var productDetails: [ProductDetailsItem]?
    var count: NSInteger?
    
    init(productDetails: [ProductDetailsItem] = [ProductDetailsItem](), count: NSInteger? = nil) {
            self.productDetails = productDetails
            self.count = count
        }
    
    
}

struct ProductDetailsResponse: Codable, Identifiable {
    
    let id = UUID()
    var productDetail: ProductDetailsItem
    
    init(productDetail: ProductDetailsItem = ProductDetailsItem()) {
            self.productDetail = productDetail
        }
    
    
}

