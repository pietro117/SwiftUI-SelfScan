//
//  CategoryView.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 19/11/2021.
//

import SwiftUI

struct CategoryView: View {

    @Binding var show: Bool
    
    var animation: Namespace.ID
    
    @State var selected: MenuCategory
    @State var productSearchResponse: ProductSearchResponse //= ProductSearchResponse()
    @State var productDetails: [ProductDetailsItem]
    @Binding var selectedItem: ProductDetailsItem
    
    var body: some View {
        
        VStack{
            
            //Header Icons - always shown
//            HStack{
//
//                Button(action: {}){
//                    Image(systemName:"magnifyingglass")
//                        .font(.title)
//                        .foregroundColor(.black)
//                }
//
////            }
//            .padding(.vertical,10)
//            .padding(.horizontal)
            
            
            //Scrollable Product List
            ScrollView{
                
                VStack{
                    
                    //Welcome Message
                    HStack{
                    
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Welcome to")
                                .font(.title)
                                .foregroundColor(.black)
                            
                            Text("The Enactor Store")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 0)
                        
                    }
                    
                    //Category Tabs
                    HStack(spacing: 0) {
                        
                        ForEach(menuCategories) {menuCategory in
                            
                            //Tab button...
                            TabButton(menuCategory: menuCategory, selected: $selected, productSearchResponse: $productSearchResponse, productDetails: $productDetails, animation: animation)
                            
                            //even spacing
                            
                            if menuCategories.last != menuCategory {
                                Spacer(minLength: 0)
                            }
                            
                        }
                        
                    }
                    .padding()
                    .padding(.top,5)
                    
                    //Product Cards
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing:10), count: 2), spacing: 15) {
                            
                        ForEach(productDetails) { productDetail in
                            
                            //Card View
                            CardView(item: productDetail, animation: animation)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        
                                        apiCall().getProductDetails(productId: productDetail.productId, locationId: locationId) { (productDetailsResponse) in
                                            selectedItem = productDetailsResponse.productDetail!
                                        
                                        show.toggle()
                                    }
                                }
                        }

                    
                }
                    .padding(10)
                }
            }
            Spacer(minLength: 0)

            }
        }
        .onAppear() {
            apiCall().getProductSearchResponse(categoryId: selected.categoryCode) { (productSearchResponse) in
                self.productSearchResponse = productSearchResponse
                self.productDetails = productSearchResponse.productDetails!
                }
            }

        

        
    }
    
}

