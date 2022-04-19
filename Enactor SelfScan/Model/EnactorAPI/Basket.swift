//
//  Basket.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 23/11/2021.
//

import Foundation
import UIKit

struct BasketItem: Codable {
    //var id: Int //=  UUID()
    var itemType: String
    var description: String
    var lineNumber: Int
    var value: Int?
    var effectiveNetValue: Int?
    var quantity: Double?
    var unitPrice: Int?
    var mmGroupId: String?
    var mmGroupDescription: String?
    var productImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        //case id
        case itemType = "@type"
        case description
        case lineNumber
        case value
        case effectiveNetValue
        case quantity
        case unitPrice
        case mmGroupId
        case mmGroupDescription
        case productImageURL
    }
    
    init(itemType: String = "", description: String = "", lineNumber: Int = 0, value: Int? = 0, effectiveNetValue: Int? = 0, quantity: Double? = 0.0, unitPrice: Int = 0, mmGroupId: String? = "", mmGroupDescription: String? = "", productImageURL: String?  = "") {
            self.itemType = itemType
            self.description = description
            self.lineNumber = lineNumber
            self.value = value
            self.effectiveNetValue = effectiveNetValue
            self.quantity = quantity
            self.unitPrice = unitPrice
            self.mmGroupId = mmGroupId
            self.mmGroupDescription = mmGroupDescription
            self.productImageURL = productImageURL
        }
}

struct Basket: Codable {
    
    //var id = UUID()
    var items: [BasketItem]
    var balance: Int
    var currencyId: String
    var saleItemQuantity: Double
    var saleItemNetValue: Int
    var promotionCalculation: PromotionCalculation?
    
    enum CodingKeys: String, CodingKey {
        //case id
        case items
        case balance
        case currencyId
        case saleItemQuantity
        case saleItemNetValue
        case promotionCalculation
    }
    
    init(
         items: [BasketItem] = [BasketItem](),
         balance: Int = 0,
         currencyId: String = "",
         saleItemQuantity: Double = 0.0,
         saleItemNetValue: Int = 0,
         promotionCalculation: PromotionCalculation? = nil) {

        self.items = items
        self.balance = balance
        self.currencyId = currencyId
        self.saleItemQuantity = saleItemQuantity
        self.saleItemNetValue = saleItemNetValue
        self.promotionCalculation = promotionCalculation
             
    }
}

struct PromotionCalculation: Codable {
    
    var itemsArray: [PromotionSavingItemWrapped]? = nil
    var totalSaving: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        //case id
        case itemsArray
        case totalSaving
    }
    
    init(
        itemsArray: [PromotionSavingItemWrapped]? = [PromotionSavingItemWrapped](),
        totalSaving: Int = 0) {

            self.itemsArray = itemsArray
            self.totalSaving = totalSaving
             
    }
}

struct PromotionSavingItemWrapped: Codable {
    
    var promotionSavingItem:PromotionSavingItem? = nil
    
    enum CodingKeys: String, CodingKey {
        //case id
        case promotionSavingItem
    }
    
    init(
        promotionSavingItem: PromotionSavingItem? = nil) {

            self.promotionSavingItem = promotionSavingItem
             
    }
}

struct PromotionSavingItem: Codable {
    
    var saving: Int? = 0
    var promotionDescription: String? = ""
    
    enum CodingKeys: String, CodingKey {
        //case id
        case saving
        case promotionDescription
    }
    
    init(
        saving: Int = 0,
        promotionDescription: String? = "") {

            self.saving = saving
            self.promotionDescription = promotionDescription
             
    }
}

struct BasketResponse: Codable {
    
    //let id = UUID()
    var basket: Basket?
    var basketType: String?
    var basketDescription: String?
    var basketStatus: String?
    var basketResponseCode: String?
    
    enum CodingKeys: String, CodingKey {
        //case id
        case basket
        case basketType
        case basketDescription
        case basketStatus
        case basketResponseCode
    }
    
    init(
         basket: Basket? = Basket(),
         basketType: String? = "",
         basketDescription: String? = "",
         basketStatus: String? = "",
         basketResponseCode: String? = "") {
             
         self.basket = basket
         self.basketType = basketType
         self.basketDescription = basketDescription
         self.basketStatus = basketStatus
         self.basketResponseCode = basketResponseCode

    }
}

struct BasketListResponse: Codable {
    
    //let id = UUID()
    
    var basketSummaries: [BasketSummary]?
    
    enum CodingKeys: String, CodingKey {
        //case id
        case basketSummaries

    }
    
    init(
        basketSummaries: [BasketSummary]? = [BasketSummary]()) {
             
         self.basketSummaries = basketSummaries
    }
}

struct BasketSummary: Codable {
    //var id: Int //=  UUID()
    var reference: String
    var type: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        //case id
        case reference
        case type
        case description
    }
    
    init(reference: String = "", type: String = "", description: String = "") {
        self.reference = reference
        self.type = type
        self.description = description
        }
}

    
struct AddBasketItem: Codable {
    
    var itemId: String
    var itemType: String
    var quantity: String
    var returnBasket: Bool
    
    enum CodingKeys: String, CodingKey {
        //case id
        case itemId
        case itemType
        case quantity
        case returnBasket
    }
    
    init(
         itemId: String,
         itemType: String,
         quantity: String,
         returnBasket: Bool = true) {
        self.itemId = itemId
        self.itemType = itemType
        self.quantity = quantity
        self.returnBasket = returnBasket
    }
}

struct AddTender: Codable {
    
    var tenderType: String
    var tenderId: String
    var tenderAmount: Int
    var referenceNumber: String
    
    enum CodingKeys: String, CodingKey {
        //case id
        case tenderType
        case tenderId
        case tenderAmount
        case referenceNumber
    }
    
    init(
        tenderType: String,
        tenderId: String,
        tenderAmount: Int,
        referenceNumber: String) {
            self.tenderType = tenderType
            self.tenderId = tenderId
            self.tenderAmount = tenderAmount
            self.referenceNumber = referenceNumber
        
    }
}
