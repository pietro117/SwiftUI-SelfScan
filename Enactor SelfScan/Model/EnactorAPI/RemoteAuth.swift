//
//  RemoteAuth.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 29/11/2021.
//

import Foundation
import UIKit

    struct RemoteAuthResponse: Codable {
        
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

    struct RemoteAuthRequest: Codable {
        
        //let id = UUID()
        var logId: String?
        var reasonType: String?
        var reasonId: String?
        var reasonDescription: String?
        var functionAuthorisationCode: String?
        var itemValue: Float?
        var itemDescription: String?
        var itemURL: String?
        var userId: String?
        var userName: String?
        var status: String?
        var approvedById: String?
        var approvedByName: String?
        
        enum CodingKeys: String, CodingKey {
            //case id
            case logId
            case reasonType
            case reasonId
            case reasonDescription
            case functionAuthorisationCode
            case itemValue
            case itemDescription
            case itemURL
            case userId
            case userName
            case status
            case approvedById
            case approvedByName
            
        }
        
        init(
            logId: String?="",reasonType: String? = "", reasonId: String? = "", reasonDescription: String? = "", functionAuthorisationCode: String? = "", itemValue: Float?=0, itemDescription: String?="", itemURL: String?="", userId: String?="", userName: String?="", status: String?="", approvedById: String?="", approvedByName: String?="") {
                
                self.logId = logId
                self.reasonType = reasonType
                self.reasonId = reasonId
                self.reasonDescription = reasonDescription
                self.functionAuthorisationCode = functionAuthorisationCode
                self.itemValue = itemValue
                self.itemValue = itemValue
                self.itemValue = itemValue
                self.itemDescription = itemDescription
                self.itemURL = itemURL
                self.userId = userId
                self.status = status
                self.approvedById = approvedById
                self.approvedByName = approvedByName
                
            }
        
    }


