//
//  RemotePers.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 29/11/2021.
//

import Foundation
import UIKit

    struct RemotePersResponse: Codable {
        
        //let id = UUID()
        var logId: String?
        var result: String?
        
        enum CodingKeys: String, CodingKey {
            //case id
            case logId
            case result
            
        }
        
        init(
            logId: String? = "", result: String? = "") {
                
                self.logId = logId
                self.result = result
                
            }
        
    }

    struct RemotePersRequest: Codable {
        
        //let id = UUID()
        var logId: String?
        var personalisationId: String?
        var itemValue: Float?
        var itemDescription: String?
        var itemURL: String?
        var userId: String?
        var userName: String?
        var status: String?
        var persString1: String?
        var persString2: String?
        var persString3: String?
        
        enum CodingKeys: String, CodingKey {
            //case id
            case logId
            case personalisationId
            case itemValue
            case itemDescription
            case itemURL
            case userId
            case userName
            case status
            case persString1
            case persString2
            case persString3
            
        }
        
        init(
            logId: String?="",personalisationId: String? = "", itemValue: Float?=0, itemDescription: String?="", itemURL: String?="", userId: String?="", userName: String?="", status: String?="", persString1: String?="", persString2: String?="", persString3: String?="") {
                
                self.logId = logId
                self.personalisationId = personalisationId
                self.itemValue = itemValue
                self.itemDescription = itemDescription
                self.itemURL = itemURL
                self.userId = userId
                self.userName = userName
                self.status = status
                self.persString1 = persString1
                self.persString2 = persString2
                self.persString3 = persString3
                
            }
        
    }


