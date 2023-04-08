//
//  LoginViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 07.04.2023.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    @Published var loggedIn = false
    @Published var username: String = "*username*"
    @Published var userType: String = "user"
    
    var isLoggedIn: Bool {
        return auth.currentUser != nil
    }
    
    func logIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.loggedIn = true
            }
            
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.loggedIn = false
    }
    
    func getUsername() {
        ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("username").observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.username = value
                }
            }
        })
    }
    
    func getUserType() {
        ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("userType").observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.userType = value
                }
            }
        })
    }
}
