//
//  SettingsPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 19.03.2023.
//

import SwiftUI

struct SettingsPageView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            self.showAlert.toggle()
            
        }, label: {
            HStack {
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Sign out")
                Spacer()
            }
        })
        .modifier(ButtonModifier())
        .padding()
        .alert(isPresented: $showAlert) {
            return Alert(title: Text("Sign out"), message: Text("Do you want to sign out?"), primaryButton: .destructive(Text("Sign out")) {
                viewModel.signOut()
            }, secondaryButton: .cancel(Text("Cancel")))
        }
    }
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
    }
}
