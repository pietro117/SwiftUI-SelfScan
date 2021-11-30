//
//  BasketView.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 19/11/2021.
//

import SwiftUI
import CodeScanner

struct BasketView: View {
    
    @State var isPresentingScanner = false
    @State var isPresentingCheckout = false
    @State var scannedCode: String?
    @State var customerId: String = "1"
    
    @State var transactionResponse: TransactionResponse = TransactionResponse()
    
    let myUtils = Utils()
    
    var body: some View {
        VStack(spacing: 10) {
            
            if self.transactionResponse.transaction != nil {
                HStack {
                    Button(action: {
                        self.clearAllItems()
                    }) {
                        Text("Clear All Items")
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
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if self.transactionResponse.transaction!.transactionId == "" {
                            
                            apiCall().getTransaction(customerId: customerId) { (transactionResponse) in
                                self.transactionResponse = transactionResponse
                                }
                        }
                        
                        self.isPresentingCheckout = true
                    }) {
                            Text("Check Out")
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
                            .padding()
                    }
                }
                
            }
            
            if self.transactionResponse.transaction!.basket.items.count > 0 {
            
                BasketList(transactionResponse: self.$transactionResponse)
                    .onAppear() {
                        
                        apiCall().getTransaction(customerId: customerId) { (transactionResponse) in
                            self.transactionResponse = transactionResponse
                            
                        }
                    
                    }
            }
            Spacer()
            if self.scannedCode != nil {
                Text("Scanned code \(self.scannedCode ?? "")")
            }
            HStack {
                if self.transactionResponse.transaction != nil {
                    Text("Basket total: \(myUtils.getIntFormat(value: transactionResponse.transaction!.basket.saleItemQuantity)) items")
                    Spacer()
                    Text (myUtils.getDisplayPrice(price: transactionResponse.transaction!.basket.saleItemNetValue))
                }
            }
            .padding()
            Button(action: {
                self.isPresentingScanner = true
            }) {
                
                HStack{
                    Image(systemName: "camera.viewfinder")
                            .font(.title2)
                            .foregroundColor(.white)
                    Text("Scan Item")
                    .fontWeight(.bold)
                        //.font(.title)
                        .padding(5)
                        
                    }
                    .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    //.padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.blue, lineWidth: 5)
                    )
            }
            .padding()
            
        }
        .sheet(isPresented: $isPresentingScanner) { self.scannerSheet }
        .sheet(isPresented: $isPresentingCheckout) { self.checkoutSheet }
        
                
    }
    
    var scannerSheet : some View {
        
        ZStack {
            CodeScannerView(
                codeTypes: [.qr,.dataMatrix,.ean8,.ean13,.code128,.interleaved2of5],
                simulatedData: "535024",
                completion: self.handleScan
            )
            Image("viewfinder")
            
        }
    }
    
    var checkoutSheet: some View {
        CheckoutView(customerId: customerId,
                     basketId:"PRIMARY",
                     basket:transactionResponse.transaction!.basket,
                     transactionId: transactionResponse.transaction!.transactionId,
                     isPresentingCheckout: $isPresentingCheckout)
    }
    
    func clearAllItems() {
        
        print("In clearAllItems")
        apiCall().deleteBasket(customerId: customerId) { }
        
        self.transactionResponse = TransactionResponse()
    }
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       //self.isShowingScanner = false
        print("In handlescan")
       
        switch result {
        case .success(let code):
            let details = code
            
            print (details)
            
            //look up product
            apiCall().getProductDetails(productId: details,
                                        locationId: "0001") { (productDetailsResponse) in

                
            //add product to basket
            apiCall().addItemToBasket(customerId: customerId,
                                      productId:productDetailsResponse.productDetail.productId,
                                      quantity: 1) { (basketResponse) in

                self.transactionResponse.transaction!.basket = basketResponse.basket!
            }
            self.scannedCode = productDetailsResponse.productDetail.description
            self.isPresentingScanner = false
        }
 
        case .failure(let error):
            print("Scanning failed \(error.localizedDescription)")
        }
        
        
    }
}
