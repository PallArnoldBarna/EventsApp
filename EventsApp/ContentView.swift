//
//  ContentView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 10.03.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
   
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.loggedIn {
                HomePageView()
            }
            else {
                LogInPageView()
            }
        }
        .onAppear {
            viewModel.loggedIn = viewModel.isLoggedIn
            viewModel.getUsername()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
    }
}
