//
//  LogInPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI
import ExytePopupView

struct LogInPageView: View {
    @State var email = ""
    @State var password = ""
    @State private var showingPopup = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            VStack {
                //Spacer()
                Text("Login")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.top, -150)
                
                TextField("Email address", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action: {
                    self.showingPopup = true
                    loginViewModel.logIn(email: email, password: password)
                }, label: {
                    Text("Login")
                        
                })
                .modifier(ButtonModifier())
                .popup(isPresented: $showingPopup) {
                    if email.isEmpty {
                        PopupView(popupText: "Email field is empty!")
                    }
                    else if email.isValidEmailAddress(email: email) == false {
                        PopupView(popupText: "Email format wrong!")
                    }
                    else if password.isEmpty {
                        PopupView(popupText: "Password field is empty!")
                    }
                    else if password.count < 6 {
                        PopupView(popupText: "Password length is smaller then the minimum!")
                    }
                }
                customize: {
                    $0.autohideIn(2)
                        .type(.toast)
                        .position(.bottom)
                        .animation(.spring())
                        .closeOnTapOutside(true)
                }
                
                NavigationLink("Don't have an account? Sing up here", destination: SignUpPageView())
                    .padding()
                
            }
            .padding()
            
            Spacer()
        }
        
    }
    
    
}

struct LogInPageView_Previews: PreviewProvider {
    static var previews: some View {
        LogInPageView()
    }
}
