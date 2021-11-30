//
//  APICalls.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 25/11/2021.
//

import Foundation

let baseURL: String = "http://52.157.215.89:39833/WebRestApi"


class apiCall {
    func getProductSearchResponse(categoryId:String,
                                  completion:@escaping (ProductSearchResponse) -> ()) {
        guard let url = URL(string: "\(baseURL)/rest/products/?q=categoryId:\(categoryId)&rows=20") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let productSearchResponse = try! JSONDecoder().decode(ProductSearchResponse.self, from: data!)
            //print(productSearchResponse)
            
            DispatchQueue.main.async {
                completion(productSearchResponse)
            }
        }
        .resume()
    }
    
    func getProductDetails(productId: String,
                           locationId: String,
                           completion:@escaping (ProductDetailsResponse) -> ()) {
        guard let url = URL(string: "\(baseURL)/rest/products/\(productId)?locationId=\(locationId)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let productDetailsResponse = try! JSONDecoder().decode(ProductDetailsResponse.self, from: data!)
            //print(productDetailsResponse)
            
            DispatchQueue.main.async {
                completion(productDetailsResponse)
            }
        }
        .resume()
    }
    
    func getCustomerBasket(customerId: String,
                           completion:@escaping (BasketResponse) -> ()) {
        
        guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY") else { return }
                            
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(customerId, forHTTPHeaderField: "subject")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            let basketResponse = try! JSONDecoder().decode(BasketResponse.self, from: data!)
            
            DispatchQueue.main.async {
                completion(basketResponse)
            }
        }
        .resume()
        
    }
    
    func addItemToBasket(customerId: String,
                         productId: String,
                         quantity: Int,
                         completion:@escaping (BasketResponse) -> ()) {
        
        
        guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY/items?returnBasket=true") else { return }
        
        let jsonData = try! JSONEncoder().encode(AddBasketItem (itemId: productId,
                                                                itemType: "PRODUCT",
                                                                quantity: "\(quantity)",
                                                                returnBasket: true))
        
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(customerId, forHTTPHeaderField: "subject")
            request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            //print(String(decoding: data!, as: UTF8.self))
            let basketResponse = try! JSONDecoder().decode(BasketResponse.self, from: data!)
            //print(basketResponse)
            
            DispatchQueue.main.async {
                completion(basketResponse)
            }
        }
        .resume()
        
    }
    
    func deleteBasket(customerId: String,
                      completion:@escaping () -> ()) {
        
        guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY") else { return }
        
        var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue(customerId, forHTTPHeaderField: "subject")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            
            DispatchQueue.main.async {
                completion()
            }
        }
        .resume()
    }
    
    func getTransaction(customerId: String,
                        completion:@escaping (TransactionResponse) -> ()) {
     
     guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY/transaction") else { return }
                         
     var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue(customerId, forHTTPHeaderField: "subject")
         request.setValue("Basic \(getBasicAuth(username: customerId, password: customerId))", forHTTPHeaderField: "Authorization")
     
         URLSession.shared.dataTask(with: request) { (data, _, _) in
             let transactionResponse = try! JSONDecoder().decode(TransactionResponse.self, from: data!)
             
             DispatchQueue.main.async {
                 completion(transactionResponse)
             }
         }
         .resume()
     }
    
    
    func updateBasketQuantity(customerId: String,
                              itemNumber: Int,
                              newQuantity: Double,
                              completion:@escaping () -> ()) {
        
        guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY/Items/\(itemNumber)/quantity") else { return }
        
        var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue(customerId, forHTTPHeaderField: "subject")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            
            DispatchQueue.main.async {
                completion()
            }
        }
        .resume()
    }
    
    
    
    func getBasicAuth(username: String, password:String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        return base64LoginString
    }
    
    
}
