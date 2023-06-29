//
//  AddAndRemoveFavouriteEventsViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 26.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class AddAndRemoveFavouriteEventsViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    @Published var favouriteEventNodeId: String = ""
    @Published var eventNodeId: String = ""
    
    func addEventToFavourites(event: Event, nodeId: String) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(event)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").child(nodeId).setValue(jsonObject)
        } catch {
            print("Error occured")
        }
    }
    
    func fetchNodeIdForEvent(event: Event) {
        let query = ref.child("Events").queryOrdered(byChild: "name").queryEqual(toValue: event.name)
        
        query.observeSingleEvent(of: .value) { snapshot in
            guard let node = snapshot.children.allObjects.first as? DataSnapshot else {
                print("Data not found")
                return
            }
            
            self.addEventToFavourites(event: event, nodeId: node.key)
        }
    }
    
    func fetchNodeIdForFavouriteEvent(event: Event) {
        let query = ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").queryOrdered(byChild: "name").queryEqual(toValue: event.name)
        
        query.observeSingleEvent(of: .value) { snapshot in
            guard let node = snapshot.children.allObjects.first as? DataSnapshot else {
                print("Data not found")
                return
            }
            
            self.removeDataFromDatabase(nodeId: node.key)
        }
    }
    
    func removeDataFromDatabase(nodeId: String) {
        let nodeRef = ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").child(nodeId)
        
        nodeRef.removeValue { error, _ in
            if let error = error {
                print("Failed to remove data: \(error)")
            } else {
                print("Data removed successfully")
            }
        }
    }
    
}
