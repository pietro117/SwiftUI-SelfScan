//
//  CardView.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import SwiftUI

struct CardView: View {
    
    var item: ProductDetailsItem
    var animation: Namespace.ID
    
    var body: some View {
        
        // utility functions here
        let myUtils = Utils()
        
        VStack{
            
            HStack{
                
                Spacer(minLength: 0)
                Text(myUtils.getDisplayPrice(price: (item.price ?? 0)))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical,8)
                    .padding(.horizontal,10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
            }
            
            //Image(item.image)
            Image(systemName: "photo")
                .data(url: URL(string: item.productImageURL ?? "")!)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                //.aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image\(item.productId)", in: animation)
                .padding(.top,15)
                .padding(.bottom)
                //.padding(.horizontal,10)
            
            Text(item.description)
                .fontWeight(.bold)
                .foregroundColor(.black)    
            
            Text(item.productId)
                .font(.caption)
                .foregroundColor(.gray)
            
            
            //Using matched Geometry Effects
            HStack{
                Button(action: {}){
                    
                    Image(systemName: "suit.heart")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                }
                .matchedGeometryEffect(id: "heart\(item.productId)", in: animation)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Text("3.5")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .matchedGeometryEffect(id: "rating\(item.productId)", in: animation)
                
            }
            .padding()
            
        }
        .background(Color(red: 210 / 255, green: 240 / 255, blue: 255 / 255)
        .matchedGeometryEffect(id: "color\(item.productId)", in: animation))
        .cornerRadius(15)
        
    }
}

