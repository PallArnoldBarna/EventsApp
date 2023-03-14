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
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.default) {
                        self.showSideMenu.toggle()
                    }
                }, label: {
                    Image(systemName: "chevron.backward")
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
            
            Toggle(isOn: $darkMode, label: {
                HStack {
                    Image(systemName: "moon.fill")
                        .font(.title)
                    
                    Text("Dark Mode")
                }
            })
            .onChange(of: darkMode) { _ in
                UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = self.darkMode ? .dark : .light
            }
            
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
