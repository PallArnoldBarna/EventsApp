//
//  SettingsPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 19.03.2023.
//

import SwiftUI

struct SettingsPageView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showAlert = false
    @Binding var darkMode: Bool
    @AppStorage("Dark/Light Mode") private var darkModeValue: Bool = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $darkMode, label: {
                HStack(spacing: 22) {
                    Image(systemName: "moon.fill")
                        .frame(width: 40, height: 40)
                        .font(.title)
                    
                    Text("Dark Mode")
                        .foregroundColor(.primary)
                }
            })
            .padding(.horizontal, 30)
            .onChange(of: darkMode) { _ in
                darkModeValue = darkMode
                if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first {
                    window.rootViewController?.view.overrideUserInterfaceStyle = self.darkModeValue ? .dark : .light
                }
            }
            .padding(.vertical, 25)
            
            NavigationLink(destination: UpdateUsernamePageView()) {
                HStack(spacing: 22) {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    
                    Text("Update username")
                        .foregroundColor(.primary)
                }
                .padding(.leading, 30)
                Spacer()
            }
            .padding(.bottom, 25)
            
            NavigationLink(destination: ChangePasswordPageView()) {
                HStack(spacing: 22) {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    
                    Text("Change password")
                        .foregroundColor(.primary)
                }
                .padding(.leading, 30)
                Spacer()
            }
            .padding(.bottom, 25)
            
            Button(action: {
                self.showAlert.toggle()
            }, label: {
                HStack(spacing: 22) {
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    
                    Text("Sign out")
                        .foregroundColor(.primary)
                }
                .padding(.leading, 30)
                Spacer()
            })
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("Sign out"), message: Text("Do you want to sign out?"), primaryButton: .destructive(Text("Sign out")) {
                    loginViewModel.signOut()
                }, secondaryButton: .cancel(Text("Cancel")))
            }
            
        .navigationBarTitle("Settings", displayMode: .inline)
        }
        .background((self.darkMode ? (Color.black) : (Color.white)).edgesIgnoringSafeArea(.all))
        Spacer()
    }
}

//struct SettingsPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsPageView()
//    }
//}
