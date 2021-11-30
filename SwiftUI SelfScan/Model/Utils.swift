//
//  Utils.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import SwiftUI

class Utils {

    public let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    func getDisplayPrice(price: Int) -> String   {
    
        let currPrice = Double(price)/100 //TODO: improve this
        guard let displayPrice = currencyFormatter.string(for: currPrice) else { return "£0.00" }
        return displayPrice
    
    }
    
    func getIntFormat(value: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        
        let number = NSNumber(value: value)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
        
    }
    
}

//allow image loading from URL
extension Image {

    func data(url:URL) -> Self {

        if let data = try? Data(contentsOf: url) {

            return Image(uiImage: UIImage(data: data)!)

            .resizable()

        }

        return self

        .resizable()

    }

}

