//
//  Home.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import SwiftUI


struct Home: View {
    
    //@State var selected = menuCategories[0]
    
    @State var show = false
    @State var selectedItem: ProductDetailsItem = ProductDetailsItem()
    @State private var tabSelection = 1
    @State var selectedCategory: MenuCategory = menuCategories[0]
    @State var productSearchResponse: ProductSearchResponse = ProductSearchResponse()
    
    @Namespace var animation
    
   // @State private var isShowingScanner = false
    
    var body: some View {
            
        TabView(selection: $tabSelection) {
                    ZStack{  
                        
                        CategoryView(show: $show,
                                     animation: animation,
                                     selected: selectedCategory,
                                     productSearchResponse: productSearchResponse,
                                     productDetails: productSearchResponse.productDetails!,
                                     selectedItem: $selectedItem
                                     )
                            .opacity(show ? 0: 1)
                            
                            if show{
                                DetailView(selectedItem: $selectedItem,
                                           show: $show,
                                           animation: animation)
                                }
                            }
                            .background(Color.white.ignoresSafeArea())
                            .tabItem {Label("Browse", systemImage: "list.dash")}
                            .tag(1)

                        if #available(iOS 15.0, *) {
                            AccountView()
                                .tabItem {Label("Account", systemImage: "person.crop.circle")}
                                .tag(3)
                        } else {
                            // Fallback on earlier versions
                        }
            
                        BasketView()
                            .tabItem {Label("Bag", systemImage: "bag")}
                            .tag(4)
            
                        PaymentsView()
                            .tabItem {Label("Payment", systemImage: "creditcard.fill")}
                            .tag(5)
            
            if #available(iOS 16.0, *) {
                RemoteAuthView()
                    .tabItem {Label("Remote Auth", systemImage: "person.fill.questionmark")}
                    .tag(6)
//                    RemotePersView()
//                        .tabItem {Label("Remote Pers", systemImage: "person.fill.questionmark")}
//                        .tag(6)
            } else {
                // Fallback on earlier versions
            }
            
            }
            
        }
        

}

