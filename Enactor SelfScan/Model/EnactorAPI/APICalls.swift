//
//  APICalls.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 25/11/2021.
//

import Foundation


var preferences = APIPreferencesLoader.load()
let baseURL: String = preferences.baseURL
let procBaseURL: String = preferences.procBaseURL
let baseRemoteAuthURL: String = preferences.baseRemoteAuthURL
let locale: String = preferences.locale
let customerId: String = preferences.customerId
let locationId: String = preferences.locationId

class apiCall {
    func getProductSearchResponse(categoryId:String,
                                  completion:@escaping (ProductSearchResponse) -> ()) {
        guard let url = URL(string: "\(baseURL)/rest/products/?q=categoryId:\(categoryId)&rows=20") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if (error != nil) {
                let productSearchResponse = ProductSearchResponse()
                completion(productSearchResponse)
                return
            }
            
            var productSearchResponse = ProductSearchResponse()
            
            if !(data!.isEmpty) {
                productSearchResponse = try! JSONDecoder().decode(ProductSearchResponse.self, from: data!)
            //print(productSearchResponse)
            }
                
            DispatchQueue.main.async {
                completion(productSearchResponse)
            }
        }
        .resume()
    }
    
    func getProductDetails(productId: String,
                           locationId: String,
                           completion:@escaping (ProductDetailsResponse) -> ()) {
        print("In getProductDetails")
        
        guard let url = URL(string: "\(baseURL)/rest/products/\(productId)?locationId=\(locationId)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in

            if (error != nil) {
                let productDetailsResponse = ProductDetailsResponse()
                completion(productDetailsResponse)
                return
            }
            
            var productDetailsResponse = ProductDetailsResponse()
            
            productDetailsResponse.response = "Not Found"
            
            if !(data!.isEmpty) {
            
                productDetailsResponse = try! JSONDecoder().decode(ProductDetailsResponse.self, from: data!)
                print(productDetailsResponse)
                
                if productDetailsResponse.productDetail != nil {
                    
                    productDetailsResponse.response = "OK"
                    //do something
                } else {
                    productDetailsResponse.response = "Not Found"
                }
            }
            
            DispatchQueue.main.async {
                completion(productDetailsResponse)
            }
        }
        .resume()
    }
    
    func getCustomerBasket(customerId: String,
                           basketId: String,
                           completion:@escaping (BasketResponse) -> ()) {
        
        guard let url = URL(string: "\(baseURL)/rest/baskets/\(basketId)") else { return }
                            
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
    
    func listCustomerBaskets(customerId: String,
                             completion:@escaping (_ basketListResponse: BasketListResponse?) -> ()) {
        
        print("In listCustomerBasketsAPICall")
    
        guard let url = URL(string: "\(baseURL)/rest/baskets") else { return }
    
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(customerId, forHTTPHeaderField: "subject")
            request.setValue("Basic \(getBasicAuth(username: customerId, password: customerId))", forHTTPHeaderField: "Authorization")
    
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var basketListResponse = BasketListResponse()
            
            if error != nil {
                            print("URLSession Error: \(String(describing: error?.localizedDescription))")
                            completion(nil)
                        } else {
                            
                            if !(data!.isEmpty) {
                                print(String(decoding: data!, as: UTF8.self))
                                
                                if data!.count > 2 {
                                    basketListResponse = try! JSONDecoder().decode(BasketListResponse.self, from: data!)
                                    print(basketListResponse)
                                } else {
                                    
                                }
                            }
                            
                            completion(basketListResponse)
                        }
        }
        task.resume()
         
    }   
    
    func addItemToBasket(customerId: String,
                         productId: String,
                         quantity: Int,
                         completion:@escaping (BasketResponse) -> ()) {
        print("In addItemToBasket")
        
        guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY/items?returnBasket=true&updatePromotions=true") else { return }
        
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
    
    func removeItemFromBasket(customerId: String,
                              lineNumber: Int,
                              completion:@escaping () -> ()) {
        
             print("In removeItemFromBasket")
             
             guard let url = URL(string: "\(baseURL)/rest/baskets/PRIMARY/items/\(lineNumber)") else { return }
             
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
                        basketId: String,
                        completion:@escaping (TransactionResponse) -> ()) {
     
     guard let url = URL(string: "\(baseURL)/rest/baskets/\(basketId)/transaction") else { return }
                         
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
    
    func addTenderToBasket(customerId: String,
                           basketId: String,
                           value: Int,
                           completion:@escaping () -> ()) {
     
        guard let url = URL(string: "\(baseURL)/rest/baskets/\(basketId)/tenders?returnBasket=true") else { return }
     
        let jsonData = try! JSONEncoder().encode(AddTender (tenderType: "CASH",
                                                            tenderId: "PBL_FR",
                                                            tenderAmount: value,
                                                            referenceNumber: "Pay by Link"))
        
        var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(customerId, forHTTPHeaderField: "subject")
            request.httpBody = jsonData
            request.setValue("Basic \(getBasicAuth(username: customerId, password: customerId))", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            //print(String(decoding: data!, as: UTF8.self))

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


