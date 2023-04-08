//
//  ContentView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 10.03.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
   
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            if loginViewModel.loggedIn {
                HomePageView()
            }
            else {
                LogInPageView()
            }
        }
        .onAppear {
            loginViewModel.loggedIn = loginViewModel.isLoggedIn
            loginViewModel.getUsername()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginViewModel())
            .environmentObject(SignUpViewModel(loginViewModel: LoginViewModel()))
    }
}
