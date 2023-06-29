//
//  SignUpPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI
import ExytePopupView

struct SignUpPageView: View {
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var passwordAgain = ""
    @State private var showingPopup = false
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @AppStorage("signupPassword") var signupPassword = ""
    @AppStorage("signupPasswordAgain") var signupPasswordAgain = ""
    
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
                    self.showingPopup.toggle()
                    signupPassword = password
                    signupPasswordAgain = passwordAgain
                    let user = User(username: username, userType: UserType.user)
                    signUpViewModel.signUp(email: email, password: password, user: user)
                }, label: {
                    Text("Sign up")
                })
                .modifier(ButtonModifier())
                .popup(isPresented: $showingPopup) {
                    if username.isEmpty {
                        PopupView(popupText: "Username field is empty!", backgroundColor: .red)
                    }
                    else if email.isEmpty {
                        PopupView(popupText: "Email field is empty!", backgroundColor: .red)
                    }
                    else if email.isValidEmailAddress(email: email) == false {
                        PopupView(popupText: "Email format wrong!", backgroundColor: .red)
                    }
                    else if signupPassword.isEmpty {
                        PopupView(popupText: "Password field is empty!", backgroundColor: .red)
                    }
                    else if signupPassword.count < 6 {
                        PopupView(popupText: "Password length is smaller then the minimum!", backgroundColor: .red)
                    }
                    else if signupPasswordAgain.isEmpty {
                        PopupView(popupText: "Password again field is empty!", backgroundColor: .red)
                    }
                    else if signupPassword != signupPasswordAgain {
                        PopupView(popupText: "The 2 passwords are not the same!", backgroundColor: .red)
                    }
                } customize: {
                    $0.autohideIn(2)
                        .type(.toast)
                        .position(.bottom)
                        .animation(.spring())
                        .closeOnTapOutside(true)
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
