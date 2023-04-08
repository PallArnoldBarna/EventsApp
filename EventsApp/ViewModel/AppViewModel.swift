//
//  AppViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    @Published var loggedIn = false
    @Published var username: String = "*username*"
    
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
                //self?.getUsername()
            }
            
        }
    }
    
    func signUp(email: String, password: String, user: User) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.loggedIn = true
                self?.addUserToDatabase(user: user)
                self?.getUsername()
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.loggedIn = false
    }
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
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
    
    func getUsername() {
        ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("username").observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.username = value
                }
            }
        })
    }
}
