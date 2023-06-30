//
//  ModifyUserDataViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 27.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class ModifyUserDataViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    func changePassword(currentPassword: String, newPassword: String) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: currentPassword)
        
        currentUser.reauthenticate(with: credential) { _, error in
            if error != nil {
                print("Failed to reauthenticate!")
            } else {
                currentUser.updatePassword(to: newPassword) { error in
                    if error != nil {
                        print("Failed to update password!")
                    }
                }
            }
        }
    }
    
    func updateUsername(newUsername: String) {
        ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").updateChildValues(["username": newUsername]) { error, _ in
            if let error = error {
                print("Failed to update username: \(error)")
            } else {
                print("Username updated successfully")
            }
        }
    }
}
