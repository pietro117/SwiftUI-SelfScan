//
//  TabButton.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import SwiftUI

struct TabButton: View {
    
    var menuCategory: MenuCategory
    @Binding var selected: MenuCategory
    @Binding var productSearchResponse: ProductSearchResponse
    @Binding var productDetails: [ProductDetailsItem]
    
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action:{
            withAnimation(.spring()){selected = menuCategory
                
                apiCall().getProductSearchResponse(categoryId: selected.categoryCode) { (productSearchResponse) in
                    self.productSearchResponse = productSearchResponse
                    productDetails = productSearchResponse.productDetails ?? [ProductDetailsItem]()
                    }
                
            }
            

            
        }) {
            
            Text(menuCategory.title)
                .font(.system(size:15))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(selected == menuCategory ? .white : .black)
                .padding(.vertical,10)
                .padding(.horizontal,selected == menuCategory ? 10 : 0)
                .background(
                    //For slide effect animation...
                    ZStack{
                        
                        if (selected == menuCategory) {
                            
                            Color.black
                                .clipShape(Capsule())
                                .matchedGeometryEffect(id: "Tab", in: animation)
                            
                        }
                    }
                )
        }
        
    }
}


