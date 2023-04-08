//
//  SignUpViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 07.04.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    
    func signUp(email: String, password: String, user: User) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.loginViewModel.loggedIn = true
                self?.addUserToDatabase(user: user)
            }
        }
    }
    
    func addUserToDatabase(user: User) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(user)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            ref.child("Users").child(auth.currentUser!.uid).setValue(jsonObject)
        } catch {
            print("Error occured")
        }
    }
    
}
