//
//  RemotePersView.swift
//  Enactor SelfScan
//
//  Created by Peter Rush on 03/07/2023.
//

import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct RemotePersView: View {
    
    @State var timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State var remotePersResponse: RemotePersResponse = RemotePersResponse()
    @State var remotePersRequest: RemotePersRequest = RemotePersRequest()
    
    @State var checkRemotePers=false
    
    @State  var pers1: String = ""
    @State  var pers2: String = ""
    @State  var pers3: String = ""
    
    var body: some View {
        
        VStack{
            
            if (!checkRemotePers) {
                
                Text("Remote Pers Disabled")
                
                Button(action: {self.checkRemotePers=true}){
                    Text("Enable Remote Pers")
                }
                
            } else {
            
            if(self.remotePersResponse.logId=="NOT_FOUND") {
                
                Text("No Personalisations active")
                
                Button(action: {self.checkRemotePers=false}){
                    Text("Disable Remote Pers")
                }
                
            } else {
                
                Text("Personalisation request Found: \(self.remotePersResponse.logId ?? "")").padding()
                
                if (self.remotePersRequest.itemDescription != "") {
                    
                    VStack{
                        Text("Item Description").fontWeight(.bold)
                        Text("\(self.remotePersRequest.itemDescription ?? "")")
                        Text("")
                        let urlString = self.remotePersRequest.itemURL ?? ""
                        
                        AsyncImage(url: URL(string: urlString),
                                   content: { image in
                                        image.resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(width:150, height: 150)
                                             .scaledToFit()
                                    },
                                   placeholder: {
                                       ProgressView()
                                   }
                            )
                          //.aspectRatio(contentMode: .fit)
                          .padding(.top,15)
                          .padding(.bottom)
                        
                        Text ("Line 1")
                        TextField("Personalisation Text 1", text: $pers1)
                        
                        Text ("Line 2")
                        TextField("Personalisation Text 2", text: $pers2)
                        
                        Text ("Line 3")
                        TextField("Personalisation Text 3", text: $pers3)
                    }
                    
                    VStack{
                        Text("")
                        Text("Requesting User").fontWeight(.bold)
                        Text("\(self.remotePersRequest.userName ?? "")")
                    }

                    Button(action: {
                        
                        remoteAuthAPICall().updatePersRequest(logId:self.remotePersResponse.logId!,
                                                    status:"UPDATED",
                                                    persString1:self.pers1,
                                                    persString2:self.pers2,
                                                    persString3:self.pers3) { () in
                            }
                        timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
                        
                        
                    }) {
                            Text("Confirm Personalisation Details")
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
                    
                    Button(action: {
                        
                        remoteAuthAPICall().updatePersRequest(logId:self.remotePersRequest.logId!,
                                                    status:"REJECTED",
                                                    persString1:"",
                                                    persString2:"",
                                                    persString3:"") { () in
                            
                            }
                        timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

                    }) {
                            Text("Cancel")
                            .fontWeight(.bold)
                                //.font(.title)
                                .padding(5)
                                .background(Color.red)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                //.padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.red, lineWidth: 5)
                                )
                            .padding()
                    }
                    
                }
                
            }
            
                
            }
        
        }.onReceive(timer) { time in
            print("The time is now \(time)")
            print("Timer Run")
            if (checkRemotePers) {
                remoteAuthAPICall().getPersForId(personalisationId:"1") { (remotePersResponse) in
                    self.remotePersResponse = remotePersResponse
                }
                if (self.remotePersResponse.logId != "NOT_FOUND" && self.remotePersResponse.logId != "") {
                    
                    AudioServicesPlayAlertSound(SystemSoundID(1322))
                    
                    remoteAuthAPICall().getPersDetails(logId:self.remotePersResponse.logId!) { (remotePersRequest) in
                        self.remotePersRequest = remotePersRequest
                        self.timer.upstream.connect().cancel()
                    }
                    
                    
                }
            }
        }
        
    }
}
