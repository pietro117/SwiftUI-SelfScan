//
//  BasketList.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 24/11/2021.
//

import SwiftUI



struct BasketList: View {
    
    @Binding var transactionResponse: TransactionResponse
    @State var basket: Basket = Basket()
    //@State var basketItem: BasketItem = BasketItem()
    
    var body: some View {
        
        //if (basket.items.count > 0) {
        
        List(transactionResponse.transaction!.basket.items.filter { $0.itemType != "orderDetailsItem"} , id: \.lineNumber) { basketItem in

                BasketRow(basketItem: basketItem,
                showExtraDetails: false,
                isDeleted: false)
            
            }
            
        //}
    }
}

