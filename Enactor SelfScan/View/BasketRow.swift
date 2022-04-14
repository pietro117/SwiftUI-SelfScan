//
//  BasketRow.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 24/11/2021.
//

import SwiftUI

struct BasketRow: View {
    
    @State var basketItem: BasketItem
    @State var showExtraDetails: Bool
    @State var isDeleted: Bool
    
    var body: some View {
        
        let myUtils = Utils()
        
        if !isDeleted {
        
            HStack {
            
                Image(systemName: "photo")
                    .data(url: URL(string: basketItem.productImageURL ?? "http://52.157.215.89:39832/WebRetailProcessing/images?resource=WEBSHOP/NoImageMedium.jpg")!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: (showExtraDetails ? 175 : 30) )
                    //.aspectRatio(contentMode: .fit)
                    //.padding(.horizontal,10)
                
                VStack{
                    HStack{
                    Text(basketItem.description)
                        .fontWeight(.heavy)
                    Spacer()
                    }
                    
                    
                    HStack{
                        Text("Qty: \(myUtils.getIntFormat(value: basketItem.quantity ?? 0))")
                        Spacer()
                        Text(myUtils.getDisplayPrice(price: basketItem.value ?? 0))
                    }
                    Spacer()
                    if showExtraDetails {
                        Button(action: {
                            self.removeItem(lineNumber: basketItem.lineNumber)
                        }){
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
    //                if showExtraDetails {
    //                    HStack {
    //                        Button(action: {
    //                            self.incrementQty()
    //                        }){
    //                            Image(systemName: "plus.square.fill")
    //                                .font(.title2)
    //                                .foregroundColor(.blue)
    //                        }
    //                        .buttonStyle(PlainButtonStyle())
    //
    //                        Button(action: {
    //                            self.decrementQty()
    //                        }){
    //                            Image(systemName: "minus.square.fill")
    //                                .font(.title2)
    //                                .foregroundColor(.blue)
    //                        }
    //                        .buttonStyle(PlainButtonStyle())
    //                        .opacity(basketItem.quantity! > 1.0 ? 1: 0)
    //
    //                        Spacer()
    //                    }
    //                }
                }
            }.onTapGesture {
                showExtraDetails.toggle()
            }
    
        }
    }
    
    
    func incrementQty() {
        self.basketItem.quantity = self.basketItem.quantity! + 1.0
        self.basketItem.value = Int(self.basketItem.quantity!) * self.basketItem.unitPrice!
    }
    
    func decrementQty() {
        self.basketItem.quantity = self.basketItem.quantity! - 1.0
        self.basketItem.value = Int(self.basketItem.quantity!) * self.basketItem.unitPrice!
    }

    func removeItem(lineNumber: Int) {
    
        //remove item from basket
        apiCall().removeItemFromBasket(customerId: "1",
                                       lineNumber: lineNumber) { }
        
        self.isDeleted = true
        }
        
}


    

