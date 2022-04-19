//
//  CheckoutView.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 25/11/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct CheckoutView: View {

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var customerId: String
    var basketId: String
    var basket: Basket
    var transactionId: String
    
    @Binding var isPresentingCheckout: Bool

    var body: some View {
        
        let myUtils = Utils()
        
        VStack{
            Button("Return to Basket") {
                isPresentingCheckout = false
            }
            .padding()
            Spacer()
            Text("Scan this QR Code on the POS to complete the transaction.")
                .fontWeight(.heavy)
                .padding()
            Text("\(myUtils.getIntFormat(value: basket.saleItemQuantity)) Items")
            Text ("Total Value: \(myUtils.getDisplayPrice(price: basket.saleItemNetValue))")
            Text ("Tranaction ID: \(transactionId)")
            Spacer()
            //Image(uiImage: generateQRCode(from: "\(customerId):\(transactionId)"))
            Image(uiImage: generateQRCode(from: "\(transactionId)"))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
            Spacer()
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

