//
//  LogInPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI
//import UIKit

struct LogInPageView: View {
    @State var email = ""
    @State var password = ""
    @State private var showAlert = false
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
                    self.showAlert.toggle()
                    loginViewModel.logIn(email: email, password: password)
                }, label: {
                    Text("Login")
                        
                })
                .modifier(ButtonModifier())
                .alert(isPresented: $showAlert) {
                    if email.isEmpty {
                        return Alert(title: Text("Email field is empty!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if email.isValidEmailAddress(email: email) == false {
                        return Alert(title: Text("Email format wrong!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if password.isEmpty {
                        return Alert(title: Text("Password field is empty!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if password.count < 6 {
                        return Alert(title: Text("Password length is smaller then the minimum!"),dismissButton: .default(Text("Got it!")))
                    }
                    else {
                        return Alert(title: Text("You are logged in!"),dismissButton: .default(Text("OK")))
                    }
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
