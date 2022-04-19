//
//  Detail.swift
//  SwiftUI SelfScan
//
//  Created by Peter Rush on 18/11/2021.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var selectedItem: ProductDetailsItem
    @Binding var show: Bool
    
    var animation: Namespace.ID
    
    @State var loadContent = false
    @State var quantityEntered: String = "1"
    @State private var shouldShowMessageLabel = false
    
    
    var body: some View {
        
        // utility functions here
        let myUtils = Utils()
        
        ScrollView{

            VStack{
                
                //Header Icons
                HStack(spacing: 25){
                    
                    Button(action: {
                        
                        //Close the view
                        withAnimation(.spring()){show.toggle()}
                    }){
                     
                        Image(systemName:"chevron.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    

                }
                .padding()
                
                //Product Details
                VStack{
                    
                    HStack{
                        
                        Spacer(minLength: 0)
                        Text(myUtils.getDisplayPrice(price: (selectedItem.price ?? 0)))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical,8)
                            .padding(.horizontal,10)
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                    }
                    
                    
//                    Image(systemName: "photo")
//                        .data(url: URL(string: selectedItem.productImageURL ?? "")!)
//                        .resizable()
//                        .scaledToFit()
//                        //.aspectRatio(contentMode: .fit)
//                        // since id is common...
//                        .matchedGeometryEffect(id: "image\(selectedItem.productId)", in: animation)
//                        .padding()

                    
                    let urlString = (selectedItem.productImageURL ?? "")!
                    
                    AsyncImage(url: URL(string: urlString),
                               content: { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fit)
                                         .frame(width:300  , height: 300)
                                         .scaledToFit()
                                },
                               placeholder: {
                                   ProgressView()
                               }
                        )
                      //.aspectRatio(contentMode: .fit)
                      .matchedGeometryEffect(id: "image\(selectedItem.productId)", in: animation)
                      .padding(.top,15)
                      .padding(.bottom)

                    
                    Text(selectedItem.description)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text(selectedItem.longDescription ?? selectedItem.productId)
                        .foregroundColor(.black)
                        .padding(.top,4)
                    
                    HStack{
                        
                        Text("3.5")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: "rating\(selectedItem.productId)", in: animation)

                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        
                        Button(action: {}){
                            
                            Image(systemName: "suit.heart")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                        }
                        .matchedGeometryEffect(id: "heart\(selectedItem.productId)", in: animation)

                    }
                    .padding()
                }
                .background(Color(red: 199 / 255, green: 249 / 255, blue: 199 / 255) //green
                .matchedGeometryEffect(id: "color\(selectedItem.productId)", in: animation))
                .cornerRadius(15)
                .padding()

                //Offer Details
                VStack{
                    
                    VStack(alignment:.leading, spacing: 8){
                        
                        Text("Exclusive Offer")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Text("Offer details here...")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color(red: 255  / 255, green: 230 / 255, blue: 230 / 255))
                    .cornerRadius(15)
                }
                .padding([.horizontal,.bottom])
                .frame(height: loadContent ? nil : 0)
                .opacity(loadContent ? 1 : 0)
                //for smooth transition
                
                Spacer(minLength: 15)
                
                VStack(alignment:.leading, spacing: 8) {
                    
                    Text("Enter quantity:")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    TextField("Quantity", text: $quantityEntered)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .cornerRadius(15)
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                //.background(Color(red: 230  / 255, green: 255 / 255, blue: 230 / 255)) //green
                .background(Color(red: 210 / 255, green: 240 / 255, blue: 255 / 255)) // blue
                
                if shouldShowMessageLabel {

                    messageLabel.transition(.asymmetric(insertion: .fadeAndSlide, removal: .fadeAndSlide))
                    Spacer()
                }
                
                Button(action: {
                    
                    //add product to basket
                    
                    // For style products, add suffix to make them a sku
                    // this is a kludge, obviously

                    
                    apiCall().addItemToBasket(customerId: "1",
                                              productId:(selectedItem.type == "styleColourSizeProduct" ? selectedItem.productId + "-11" : selectedItem.productId),
                                              quantity: 1, completion: { _ in })
                    
                    self.animateAndDelayWithSeconds(1) { self.shouldShowMessageLabel = true }
                    self.animateAndDelayWithSeconds(3) { self.shouldShowMessageLabel = false }

                }) {
                    
                    Text("ADD TO BAG")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color.black)
                        .cornerRadius(15)
                }
                .padding(.vertical)
            }
            .onAppear{
                
                withAnimation(Animation.spring().delay(0.45)){
                    loadContent.toggle()
                }
                
            }
            

        
        }
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
            Text("Product added to Bag")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }
        .frame(height: 44.0)
        .background(Color.red)
    }
    
}

