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
        
            if basketItem.itemType != "cashTenderItem" {
            
                HStack {
                
                    Image(systemName: "photo")
                        .data(url: URL(string: basketItem.productImageURL ?? "\(procBaseURL)/images?resource=WEBSHOP/NoImageMedium.jpg")!)
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
                    
                    }
                }.onTapGesture {
                    showExtraDetails.toggle()
                }
            } else if basketItem.itemType == "cashTenderItem" {
                
                // Tenderitem  - only show if negative value: ignore change
                if (basketItem.value ?? 0) < 0 {
                    HStack {
                    
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20 )
                            //.aspectRatio(contentMode: .fit)
                            .padding(.horizontal,10)
                        
                        VStack{
                            HStack{
                            Text(basketItem.description)
                                .fontWeight(.heavy)
                            Spacer()
                            }
                            
                            
                            HStack{
                                
                                Spacer()
                                Text(myUtils.getDisplayPrice(price: basketItem.value ?? 0))
                            }
                            Spacer()

                        }
                    }
                }
        
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


    

