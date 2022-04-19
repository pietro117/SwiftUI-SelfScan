//
//  PaymentsView.swift
//  Enactor SelfScan
//
//  Created by Peter Rush on 12/12/2022.
//

import SwiftUI

struct PaymentsView: View {
    
    @State var basketSummary: BasketSummary = BasketSummary()
    @State var transactionResponse: TransactionResponse = TransactionResponse()
    
    @State private var shouldShowMessageLabel = false
    
    let myUtils = Utils()
    
    var body: some View {
        
        VStack{
            
            HStack{
                Button(action: {
                    self.listCustomerBaskets()
                }){
                    Text("Get Basket")
                    .fontWeight(.bold)
                        //.font(.title)
                        .padding(5)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        //.padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.blue, lineWidth: 5)
                    )
                }.padding()
                VStack{
                    Text("Cust ID: \(1)")
                    Text("Name: Nomi Betterman")
                }
            }
            
            Spacer()
            
            Text("Ref: \(basketSummary.reference)")
            
            Spacer()
            
            if self.transactionResponse.transaction != nil {
                
                if self.transactionResponse.transaction!.basket.items.count > 0 {
            
                    BasketList(transactionResponse: self.$transactionResponse)
                }
            }
            
            Spacer()
            
            HStack {
                if self.transactionResponse.transaction != nil {
                    
                    Button(action: {
                        apiCall().getTransaction(customerId: customerId,
                                                 basketId: basketSummary.reference) { (transactionResponse) in
                            self.transactionResponse = transactionResponse
                        }
                    }) {
                        Text("Basket total:")
                    }
                    
                    Text("\(myUtils.getIntFormat(value: transactionResponse.transaction!.basket.saleItemQuantity)) items")
                    Spacer()
                    Text (myUtils.getDisplayPrice(price: transactionResponse.transaction!.basket.saleItemNetValue))
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                self.applyPayment()
            }){
                Text("Pay for Basket")
                .fontWeight(.bold)
                    //.font(.title)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    //.padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.blue, lineWidth: 5)
                )
            }.padding()
            
            if shouldShowMessageLabel {

                messageLabel.transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                Spacer()
            }
            
        }
            .onAppear() {
                self.listCustomerBaskets()
                }
    }
    
    func listCustomerBaskets() {
        
        print("In listCustomerBaskets")
        apiCall().listCustomerBaskets(customerId: preferences.customerId) { (basketListResponse) in

            if (basketListResponse?.basketSummaries!.count)! > 0 {
                basketSummary = basketListResponse!.basketSummaries?[0] ?? BasketSummary()
                apiCall().getTransaction(customerId: customerId,
                                         basketId: basketSummary.reference) { (transactionResponse) in
                    self.transactionResponse = transactionResponse
                }
            }

            
            }
    }
    
    func applyPayment(){
        
        print("In ApplyPayment")
        
        self.animateAndDelayWithSeconds(1) { self.shouldShowMessageLabel = true }
        
        apiCall().addTenderToBasket(customerId: preferences.customerId,
                                    basketId: basketSummary.reference,
                                    value: transactionResponse.transaction!.basket.saleItemNetValue) { () in
            
            self.listCustomerBaskets()
            
            }
        self.animateAndDelayWithSeconds(3) { self.shouldShowMessageLabel = false }

    }

    func animateAndDelayWithSeconds(_ seconds: TimeInterval, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            withAnimation {
                action()
            }
        }
    }

    var messageLabel: some View {
        HStack {
            Spacer()
            Text("Pay by Link Recorded")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(height: 44.0)
        .background(Color.red)
    }
    
    
    
}


