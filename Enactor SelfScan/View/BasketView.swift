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
            
            if self.transactionResponse.transaction != nil {
                
                if self.transactionResponse.transaction!.basket.items.count > 0 {
            
                    BasketList(transactionResponse: self.$transactionResponse)
                }
                
                Spacer()
                
                //Promo Details
                if self.transactionResponse.transaction!.basket.promotionCalculation != nil {
                    VStack{
                        
                        VStack(alignment:.leading, spacing: 8){
                            
                            Text("Exclusive Deal")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Text(self.transactionResponse.transaction!.basket.promotionCalculation?.itemsArray![0].promotionSavingItem?.promotionDescription ?? "")
                                .foregroundColor(.gray)
                            Text("Saving: \(myUtils.getDisplayPrice(price: transactionResponse.transaction!.basket.promotionCalculation?.totalSaving ?? 0))")
                            }
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                        .background(Color(red: 255  / 255, green: 230 / 255, blue: 230 / 255))
                        .cornerRadius(15)
                    }
                    Spacer()

            }
            
            
            if self.scannedCode != nil {
                Text("Scanned code \(self.scannedCode ?? "")")
            }
            HStack {
                if self.transactionResponse.transaction != nil {
                    
                    Button(action: {
                        apiCall().getTransaction(customerId: customerId) { (transactionResponse) in
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
        .onAppear() {
            
            apiCall().getTransaction(customerId: customerId) { (transactionResponse) in
                self.transactionResponse = transactionResponse
                
            }
        
        }
                
    }
    
    
    var scannerSheet : some View {
        
        ZStack {
            CodeScannerView(
                codeTypes: [.qr,.dataMatrix,.ean8,.ean13,.code128,.interleaved2of5],
                simulatedData: "535024",
                completion: self.handleScan
            )
            #if targetEnvironment(simulator)
              // Dont show viewfinder
            #else
                Image("viewfinder")
            #endif
            
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
        
        self.scannedCode = ""
    }
    
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       //self.isShowingScanner = false
        print("In handlescan")
       
        switch result {
        case .success(let code):
            //let details = code
            
            //trim off newlines etc from barcode
            let details = code.components(separatedBy: .whitespacesAndNewlines).joined()
            
            print (details)
            
            //look up product
            apiCall().getProductDetails(productId: details,
                                        locationId: locationId) { (productDetailsResponse) in

            //add product to basket
            apiCall().addItemToBasket(customerId: customerId,
                                      productId:productDetailsResponse.productDetail.productId,
                                      quantity: 1) { (basketResponse) in
                
                if self.transactionResponse.transaction == nil {
                    
                    self.transactionResponse.transaction = Transaction()
                    
                }

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
