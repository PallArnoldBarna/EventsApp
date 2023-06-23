//
//  AddUserViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 23.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class AddUserViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    func createUser(email: String, password: String, user: User) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            guard let userID = result?.user.uid else {
                return
            }
            
            DispatchQueue.main.async {
            
                self?.addUserToDatabase(user: user, userID: userID)
                try? self?.auth.signOut()
                self?.auth.signIn(withEmail: "admin@gmail.com", password: "admin1") { [weak self] result, error in
                    guard result != nil, error == nil else {
                        return
                    }
                }
            }
        }
        
    }
    
    func addUserToDatabase(user: User, userID: String) {
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

struct ServiceAccount: Codable {
    let apiKey: String
    let projectID: String
    let bundleID: String
    let clientID: String
    let databaseURL: String
    let storageBucket: String
}
