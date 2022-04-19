//
//  RemoteAuthView.swift
//  Enactor SelfScan
//
//  Created by Peter Rush on 03/07/2023.
//

import SwiftUI
import AVFoundation

@available(iOS 16.0, *)
struct RemoteAuthView: View {
    
    @State var timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State var remoteAuthResponse: RemoteAuthResponse = RemoteAuthResponse()
    @State var remoteAuthRequest: RemoteAuthRequest = RemoteAuthRequest()
    
    @State var checkRemoteAuth=false
    
    
    var body: some View {
        
        VStack{
            
            if (!checkRemoteAuth) {
                
                Text("Remote Auth Disabled")
                
                Button(action: {self.checkRemoteAuth=true}){
                    Text("Enable Remote Auth")
                }
                
            } else {
            
            if(self.remoteAuthResponse.logId=="NOT_FOUND") {
                
                Text("No authorisations active")
                
                Button(action: {self.checkRemoteAuth=false}){
                    Text("Disable Remote Auth")
                }
                
            } else {
                
                Text("Authorisation Log Found: \(self.remoteAuthResponse.logId ?? "")").padding()
                
                if (self.remoteAuthRequest.reasonType != "") {
                    
                    VStack{
                        Text("Authorisation Reason Type").fontWeight(.bold)
                        Text("\(self.remoteAuthRequest.reasonType ?? "")")
                        Text("")
                        Text("Authorisation Reason ID").fontWeight(.bold)
                        Text("\(self.remoteAuthRequest.reasonId ?? "")")
                        Text("")
                        Text("Authorisation Reason Description").fontWeight(.bold)
                        Text("\(self.remoteAuthRequest.reasonDescription ?? "")")
                    }
                    
                    VStack{
                        Text("")
                        Text("Requesting User").fontWeight(.bold)
                        Text("\(self.remoteAuthRequest.userName ?? "")")
                    }

                    Button(action: {
                        
                        remoteAuthAPICall().updateAuthRequest(logId:self.remoteAuthResponse.logId!,
                                                    status:"ACCEPTED",
                                                    approvedById:"1",
                                                    approvedByName:"Michael Carrell") { () in
                            
                            }
                        timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
                        
                        
                    }) {
                            Text("Approve Request")
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
                        
                        remoteAuthAPICall().updateAuthRequest(logId:self.remoteAuthRequest.logId!,
                                                    status:"REJECTED",
                                                    approvedById:"1",
                                                    approvedByName:"Michael Carrell") { () in
                            
                            }
                        timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

                    }) {
                            Text("Decline Request")
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
            if (checkRemoteAuth) {
                remoteAuthAPICall().getAuthForCode(authCode:"MANAGER-UK") { (remoteAuthResponse) in
                    self.remoteAuthResponse = remoteAuthResponse
                }
                if (self.remoteAuthResponse.logId != "NOT_FOUND" && self.remoteAuthResponse.logId != "") {
                    
                    AudioServicesPlayAlertSound(SystemSoundID(1322))
                    
                    remoteAuthAPICall().getAuthDetails(logId:self.remoteAuthResponse.logId!) { (remoteAuthRequest) in
                        self.remoteAuthRequest = remoteAuthRequest
                        self.timer.upstream.connect().cancel()
                    }
                    
                    
                }
            }
        }
        
    }
}
