//
//  APICalls.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 25/11/2021.
//

import Foundation


class remoteAuthAPICall {
 
    
    func getAuthForCode(authCode: String,
                           completion:@escaping (RemoteAuthResponse) -> ()) {
     
        guard let url = URL(string: "\(baseRemoteAuthURL)/api/getAuthForCode?functionAuthorisationCode=\(authCode)") else { return }
     
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
            URLSession.shared.dataTask(with: request) { (data, _, _) in
                let remoteAuthResponse = try! JSONDecoder().decode(RemoteAuthResponse.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(remoteAuthResponse)
                }
            }
            .resume()
        }
    
    func getAuthDetails(logId: String,
                           completion:@escaping (RemoteAuthRequest) -> ()) {
     
        guard let url = URL(string: "\(baseRemoteAuthURL)/api/authRequest?logId=\(logId)") else { return }
     
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
            URLSession.shared.dataTask(with: request) { (data, _, _) in
                let remoteAuthRequest = try! JSONDecoder().decode (RemoteAuthRequest.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(remoteAuthRequest)
                }
            }
            .resume()
        }
    
    func updateAuthRequest(logId: String,
                           status: String,
                           approvedById: String,
                           approvedByName: String,
                           completion:@escaping () -> ()) {
     
        guard let url = URL(string: "\(baseRemoteAuthURL)/api/authRequest") else { return }
     
        let jsonData = try! JSONEncoder().encode(RemoteAuthRequest (logId: logId,
                                                                    status: status,
                                                                    approvedById: approvedById,
                                                                    approvedByName: approvedByName))
        
        var request = URLRequest(url: url)
            request.httpMethod = "PUT"
        
            request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("-----> data: \(data!)")
                print (String(decoding: data!, as: UTF8.self))
                
            }
            .resume()
        }
    
    
    
    func getPersForId(personalisationId: String,
                           completion:@escaping (RemotePersResponse) -> ()) {
     
        guard let url = URL(string: "\(baseRemoteAuthURL)/api/getPersForId?personalisationId=\(personalisationId)") else { return }
     
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
            URLSession.shared.dataTask(with: request) { (data, _, _) in
                let remotePersResponse = try! JSONDecoder().decode(RemotePersResponse.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(remotePersResponse)
                }
            }
            .resume()
        }
    
    func getPersDetails(logId: String,
                           completion:@escaping (RemotePersRequest) -> ()) {
     
        guard let url = URL(string: "\(baseRemoteAuthURL)/api/persRequest?logId=\(logId)") else { return }
     
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
            URLSession.shared.dataTask(with: request) { (data, _, _) in
                let remotePersRequest = try! JSONDecoder().decode (RemotePersRequest.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(remotePersRequest)
                }
            }
            .resume()
        }
    
    func updatePersRequest(logId: String,
                           status: String,
                           persString1: String,
                           persString2: String,
                           persString3: String,
                           completion:@escaping () -> ()) {
     
        guard let url = URL(string: "\(baseRemoteAuthURL)/api/persRequest") else { return }
     
        let jsonData = try! JSONEncoder().encode(RemotePersRequest (logId: logId,
                                                                    status: status,
                                                                    persString1: persString1,
                                                                    persString2: persString2,
                                                                    persString3: persString3))
        
        var request = URLRequest(url: url)
            request.httpMethod = "PUT"
        
            request.setValue("\(String(describing: jsonData.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("-----> data: \(data!)")
                print (String(decoding: data!, as: UTF8.self))
                
            }
            .resume()
        }
    
    
}


