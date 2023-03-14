//
//  SignUpPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI

struct SignUpPageView: View {
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var passwordAgain = ""
    @State private var showAlert = false
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack {
                Text("Sign up")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.top, -150)
                
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                TextField("Email address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password again", text: $passwordAgain)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button(action: {
                    self.showAlert.toggle()
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Sign up")
                })
                .modifier(ButtonModifier())
                .alert(isPresented: $showAlert) {
                    
                    if username.isEmpty {
                        return Alert(title: Text("Username field is empty!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if email.isEmpty {
                        return Alert(title: Text("Email field is empty!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if viewModel.isValidEmailAddress(email: email) == false {
                        return Alert(title: Text("Email format wrong!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if password.isEmpty {
                        return Alert(title: Text("Password field is empty!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if password.count < 6 {
                        return Alert(title: Text("Password length is smaller then the minimum!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if passwordAgain.isEmpty {
                        return Alert(title: Text("Password again field is empty!"),dismissButton: .default(Text("Got it!")))
                    }
                    else if password != passwordAgain {
                        return Alert(title: Text("The 2 passwords are not the same!"),dismissButton: .default(Text("Got it!")))
                    }
                    else {
                        return Alert(title: Text("You are signed up and logged in!"),dismissButton: .default(Text("OK")))
                    }
                }
                
            }
            .padding()
            
            Spacer()
        }
        
    }
    
}

struct SignUpPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPageView()
    }
}
