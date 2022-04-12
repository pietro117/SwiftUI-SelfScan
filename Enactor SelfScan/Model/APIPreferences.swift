//
//  APIPreferences.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 07/04/2022.
//

import Foundation

struct APIPreferences: Codable {
    var customerId: String
    var baseURL: String
    var procBaseURL: String
    var locale: String
    var locationId: String
}

class APIPreferencesLoader {
  static private var plistURL: URL {
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documents.appendingPathComponent("api_preferences.plist")
  }

  static func load() -> APIPreferences {
    let decoder = PropertyListDecoder()

    guard let data = try? Data.init(contentsOf: plistURL),
      let preferences = try? decoder.decode(APIPreferences.self, from: data)
      else {
        copyPreferencesFromBundle()
        return load()
    }
    return preferences
  }
    
    
  //Get Default file from bundle if required
    static func copyPreferencesFromBundle() {
      if let path = Bundle.main.path(forResource: "api_preferences", ofType: "plist"),
        let data = FileManager.default.contents(atPath: path),
        FileManager.default.fileExists(atPath: plistURL.path) == false {
          FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
      }
    }
    
    static func write(preferences: APIPreferences) {
      let encoder = PropertyListEncoder()

      if let data = try? encoder.encode(preferences) {
        if FileManager.default.fileExists(atPath: plistURL.path) {
          // Update an existing plist
          try? data.write(to: plistURL)
        } else {
            // Create a new plist
            // Shouldnt happen
          FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
        }
      }
    }
    
}


