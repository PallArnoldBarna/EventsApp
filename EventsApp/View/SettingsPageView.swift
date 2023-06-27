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
    
    var body: some View {
        VStack {
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
            .padding(.top, 25)
            
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
        Spacer()
    }
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
    }
}
