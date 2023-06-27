//
//  ChangePasswordPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 27.06.2023.
//

import SwiftUI

struct ChangePasswordPageView: View {
    @EnvironmentObject var modifyUserDataViewModel: ModifyUserDataViewModel
    @State var currentPassword = ""
    @State var newPassword = ""
    @State var newPasswordConfirm = ""
    @State var showPopup = false
    
    var body: some View {
        VStack {
            
            Text("Change password")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.top, 50)
                .padding(.bottom, 30)
            
            SecureField("Current password", text: $currentPassword)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("New password", text: $newPassword)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
            
            SecureField("Confirm new password", text: $newPasswordConfirm)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .padding(.bottom, 30)
            
            Button(action: {
                self.showPopup.toggle()
                modifyUserDataViewModel.changePassword(currentPassword: currentPassword, newPassword: newPassword)
            }, label: {
                Text("Change password")
            })
            .modifier(ButtonModifier())
            .popup(isPresented: $showPopup) {
                if currentPassword.isEmpty {
                    PopupView(popupText: "Current password field is empty!", backgroundColor: .red)
                }
                else if newPassword.isEmpty {
                    PopupView(popupText: "New password field is empty!", backgroundColor: .red)
                }
                else if newPassword.count < 6 {
                    PopupView(popupText: "New password length is smaller then the minimum!", backgroundColor: .red)
                }
                else if newPasswordConfirm.isEmpty {
                    PopupView(popupText: "New password confirm field is empty!", backgroundColor: .red)
                }
                else if newPassword != newPasswordConfirm {
                    PopupView(popupText: "The 2 new passwords are not the same!", backgroundColor: .red)
                }
                else {
                    PopupView(popupText: "Password changed successfully!", backgroundColor: .green)
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

struct ChangePasswordPageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordPageView()
    }
}
