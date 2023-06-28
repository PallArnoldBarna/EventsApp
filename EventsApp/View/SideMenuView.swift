//
//  SideMenuView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 12.03.2023.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var darkMode: Bool
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.default) {
                        self.showSideMenu.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                })
                Text("EventsApp")
                    .padding(.leading)
                    .font(.system(size: 20))
                Spacer()
            }
            .padding(.top)
            .padding(.bottom, 25)
            
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                
                Text(loginViewModel.username.prefix(1))
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    
            }
            
            Text(loginViewModel.username)
                .font(.system(size: 30))
                .padding(.bottom, 25)
            
            NavigationLink(destination: FavouriteEventsPageView()) {
                HStack(spacing: 22) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Favourites")
                }
                Spacer()
            }
            .simultaneousGesture(TapGesture().onEnded{
                withAnimation(.default) {
                    self.showSideMenu.toggle()
                }
            })
            .padding(.top, 25)
            
            NavigationLink(destination: SettingsPageView(darkMode: self.$darkMode)) {
                HStack(spacing: 22) {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Settings")
                }
                Spacer()
            }
            .simultaneousGesture(TapGesture().onEnded{
                withAnimation(.default) {
                    self.showSideMenu.toggle()
                }
            })
            .padding(.top, 25)
            
            NavigationLink(destination: AdminPageView()) {
                HStack(spacing: 22) {
                    Image(systemName: "wrench.adjustable.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Admin page")
                }
                Spacer()
            }
            .simultaneousGesture(TapGesture().onEnded{
                withAnimation(.default) {
                    self.showSideMenu.toggle()
                }
            })
            .padding(.top, 25)
            .isHidden(loginViewModel.userType != UserType.admin)
            
            Spacer()
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background((self.darkMode ? (Color.black) : (Color.white)).edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
        .onAppear {
            loginViewModel.getUsername()
            loginViewModel.getUserType()
        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    @State private var darkMode = false
//    @State private var showSideMenu = false
//    static var previews: some View {
//        SideMenuView(darkMode: self.$darkMode, showSideMenu: self.$showSideMenu)
//    }
//}
