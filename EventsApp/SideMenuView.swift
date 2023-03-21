//
//  SideMenuView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 12.03.2023.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var darkMode: Bool
    @Binding var showSideMenu: Bool
    @AppStorage("Dark/Light Mode") private var darkModeValue: Bool = false
    
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
                
                Text("A")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    
            }
            
            Text("User")
                .font(.system(size: 30))
                .padding(.bottom, 50)
            
            Toggle(isOn: $darkMode, label: {
                HStack {
                    Image(systemName: "moon.fill")
                        .frame(width: 25, height: 25)
                        .font(.title)
                    
                    Text("Dark Mode")
                        .padding(.leading, 12)
                }
            })
            .onChange(of: darkMode) { _ in
                darkModeValue = darkMode
                if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first {
                    window.rootViewController?.view.overrideUserInterfaceStyle = self.darkModeValue ? .dark : .light
                }
            }
            
            NavigationLink(destination: SettingsPageView()) {
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
            
            
            Spacer()
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background((self.darkMode ? (Color.black) : (Color.white)).edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
        
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    @State private var darkMode = false
//    @State private var showSideMenu = false
//    static var previews: some View {
//        SideMenuView(darkMode: self.$darkMode, showSideMenu: self.$showSideMenu)
//    }
//}
