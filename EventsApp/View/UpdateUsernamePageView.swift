//
//  UpdateUsernamePageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 27.06.2023.
//

import SwiftUI

struct UpdateUsernamePageView: View {
    @EnvironmentObject var modifyUserDataViewModel: ModifyUserDataViewModel
    @State var newUsername = ""
    @State var showPopup = false
    
    var body: some View {
        VStack {
            
            Text("Update username")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.top, 50)
                .padding(.bottom, 30)
            
            TextField("New username", text: $newUsername)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .padding(.bottom, 30)
            
            Button(action: {
                self.showPopup.toggle()
                if !newUsername.isEmpty {
                    modifyUserDataViewModel.updateUsername(newUsername: newUsername)
                }
            }, label: {
                Text("Update username")
            })
            .modifier(ButtonModifier())
            .popup(isPresented: $showPopup) {
                if newUsername.isEmpty {
                    PopupView(popupText: "Field is empty ", backgroundColor: .red)
                }
                else {
                    PopupView(popupText: "Username updated successfully!", backgroundColor: .green)
                }
            } customize: {
                $0.autohideIn(1)
                    .type(.toast)
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct UpdateUsernamePageView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUsernamePageView()
    }
}
