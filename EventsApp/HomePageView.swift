//
//  HomePageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showAlert = false
    @State private var darkMode = false
    @State private var showSideMenu = false
    var body: some View {
        
        ZStack(alignment: .leading) {
            GeometryReaderCentered { _ in
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                withAnimation(.default) {
                                    self.showSideMenu.toggle()
                                }
                            }, label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            })
                            
                            Spacer()
                        }
                        Text("Home")
                    }
                    .padding()
                    .foregroundColor(.primary)
                    .overlay(Rectangle().stroke(Color.primary.opacity(0.1), lineWidth: 1).shadow(radius: 3).edgesIgnoringSafeArea(.top))
                    
                    Spacer()
                    
                    Text("You are logged in")
                    
                    Button(action: {
                        self.showAlert.toggle()
                        
                    }, label: {
                        Text("Sign out")
                            .frame(width: 200, height: 50)
                    })
                    .modifier(ButtonModifier())
                    .padding()
                    .alert(isPresented: $showAlert) {
                        return Alert(title: Text("Sign out"), message: Text("Do you want to sign out?"), primaryButton: .destructive(Text("Sign out")) {
                            viewModel.signOut()
                        }, secondaryButton: .cancel(Text("Cancel")))
                    }
                    
                    Spacer()
                }
                
            }
            
            HStack {
                SideMenuView(darkMode: self.$darkMode, showSideMenu: self.$showSideMenu)
                    .preferredColorScheme(self.darkMode ? .dark : .light)
                    .offset(x: self.showSideMenu ? 0 : -UIScreen.main.bounds.width / 1.5)
                
                Spacer(minLength: 0)
            }
            .background(Color.primary.opacity(self.showSideMenu ? (self.darkMode ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
            
                
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
