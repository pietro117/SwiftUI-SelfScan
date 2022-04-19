//
//  ProductListItem.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import Foundation


struct ProductDetailsItem: Codable, Identifiable {
    var id = UUID()
    var productId: String = ""
    var description: String = ""
    var longDescription: String? = ""
    var price: NSInteger? = 0
    var productImageURL: String? = ""
    var type: String = ""
    
    init(productId: String = "", description: String = "", longDescription: String? = "", price: NSInteger? = 0, productImageURL: String? = "", type: String = "") {
            self.productId = productId
            self.description = description
            self.longDescription = longDescription
            self.price = price
            self.productImageURL = productImageURL
            self.type = type
        }
}

struct ProductSearchResponse: Codable, Identifiable {
    
    var id = UUID()
    var productDetails: [ProductDetailsItem]?
    var count: NSInteger?
    
    init(productDetails: [ProductDetailsItem] = [ProductDetailsItem](), count: NSInteger? = nil) {
            self.productDetails = productDetails
            self.count = count
        }
    
    
}

struct ProductDetailsResponse: Codable, Identifiable {
    
    var id = UUID()
    var response: String?
    var productDetail: ProductDetailsItem?
    
    init(productDetail: ProductDetailsItem? = ProductDetailsItem(), response: String? = "") {
            self.response = response
            self.productDetail = productDetail
        }
    
    
    
}

