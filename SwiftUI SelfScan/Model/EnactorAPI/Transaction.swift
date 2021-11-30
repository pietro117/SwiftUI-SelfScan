//
//  Transaction.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 29/11/2021.
//

import Foundation
import UIKit

    struct Transaction: Codable {
        //let id = UUID()
        var transactionId: String
        var basket: Basket
        
        enum CodingKeys: String, CodingKey {
            //case id
            case transactionId
            case basket
        }
        
        init(
            transactionId: String = "",
            basket: Basket = Basket()) {

            self.transactionId = transactionId
            self.basket = basket
        }
    }
    
    struct TransactionResponse: Codable {
        
        //let id = UUID()
        var transaction: Transaction?
        
        enum CodingKeys: String, CodingKey {
            //case id
            case transaction
            
        }
        
        init(
            transaction: Transaction? = Transaction()) {
                 
             self.transaction = transaction
             
        }
    }

