//
//  LoginScreen.swift
//  My Wallet App
//
//  Created by Mohit Sengar on 28/10/24.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject var loginData = LoginData()
    @EnvironmentObject var evLoginData : LoginData
    @State var isValidLogins : Bool = false
    @State var isPresentedAlert:Bool = false
    @State private var alertMessage = ""
    @State var showModally:Bool = false
    
    var body: some View {
        VStack{
            if(isValidLogins){
                    ContentView()
            }else{
                Spacer()
            
                Text("Welcome to My Wallet App ").font(.title)
            
                Spacer()
            
                VStack{
                    TextField("User Id".capitalized, text: $loginData.loginId)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Password".capitalized, text: $loginData.loginPassword)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 15) // Left padding
                        .padding(.trailing, 15)// Right padding
                                        
                }.padding()
                
                Spacer()
                
                VStack{
                    Button("Login") {
                        print("Login Button Clicked")
                        isValidLogins = performValidations()
                        if(!isValidLogins){
                            isPresentedAlert = true
                        }
                    }
                    
                    Button("Login Options") {
                        print("Login Button Clicked")
                        showModally = true
                    }.padding()
                }.tint(.accentColor)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                
                Spacer()
                        
            }
        }.alert("Alert", isPresented: $isPresentedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }.sheet(isPresented: $showModally) {
            LoginOptionsView(showModally: $showModally,isValidLogins: $isValidLogins) // Present the LoginOptionsView
        }
    }
    
    func performValidations() -> Bool {
        if loginData.loginId.isEmpty || loginData.loginId.count<1 {
            alertMessage = "Please enter the user ID first."
            return false
        } else if loginData.loginId.isEmpty || loginData.loginId.count<1 {
            alertMessage = "Please enter the password first."
            return false
        }
        return true
    }
}

#Preview {
    LoginScreen()
}
