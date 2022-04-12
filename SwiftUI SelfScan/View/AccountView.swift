//
//  AccountView.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 19/11/2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct AccountView: View {
    
    enum Field {
            case customerId
            case baseURL
            case procBaseURL
            case locale
            case locationId
        }
    
    @State private var preferences = APIPreferencesLoader.load()
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack{
            VStack {
                
                Text("Customer Id")
                    .fontWeight(.bold)
                TextField("Customer ID", text: $preferences.customerId)
                    .focused($focusedField, equals: .customerId)
                Text("API Base URL")
                    .fontWeight(.bold)
                TextField("Base URL", text: $preferences.baseURL)
                    .focused($focusedField, equals: .baseURL)
                Text("Processing Base URL")
                    .fontWeight(.bold)
                TextField("Processing URL", text: $preferences.procBaseURL)
                    .focused($focusedField, equals: .procBaseURL)
                Text("Locale")
                    .fontWeight(.bold)
                TextField("Locale", text: $preferences.locale)
                    .focused($focusedField, equals: .locale)
                Text("Location Id")
                    .fontWeight(.bold)
                TextField("Location Id", text: $preferences.locationId)
                    .focused($focusedField, equals: .locationId)
            }
            Spacer()
            VStack{
                
                Button("Update", action: {
                    APIPreferencesLoader.write(preferences: self.preferences)
                  })
                
            }
            .onSubmit {
                switch focusedField {
                    case .customerId:
                        focusedField = .baseURL
                    case .baseURL:
                        focusedField = .procBaseURL
                case .procBaseURL:
                    focusedField = .locale
                case .locale:
                    focusedField = .locationId

                    default:
                        print("Creating account…")
                    }
            }
            Spacer()
        }
        
    }
}

