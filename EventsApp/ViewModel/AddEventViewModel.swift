//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 23.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class AddEventViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    func addEventToDatabase(event: Event) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(event)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            ref.child("Events").childByAutoId().setValue(jsonObject)
        } catch {
            print("Error occured")
        }
    }
}
