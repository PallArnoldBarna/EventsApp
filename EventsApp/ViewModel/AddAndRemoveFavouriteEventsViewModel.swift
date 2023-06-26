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
    
    func addEventToFavourites(event: Event) {
        do {
            self.updateEvent(isFavourite: event.isFavourite, nodeId: eventNodeId)
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(event)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").child(eventNodeId).setValue(jsonObject)
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
            
            self.eventNodeId = node.key
            self.addEventToFavourites(event: event)
        }
    }
    
    func fetchNodeIdForFavouriteEvent(event: Event) {
        let query = ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").queryOrdered(byChild: "name").queryEqual(toValue: event.name)
        
        query.observeSingleEvent(of: .value) { snapshot in
            guard let node = snapshot.children.allObjects.first as? DataSnapshot else {
                print("Data not found")
                return
            }
            
            self.favouriteEventNodeId = node.key
            self.removeDataFromDatabase(nodeId: self.favouriteEventNodeId, isFavourite: event.isFavourite)
        }
    }
    
    func removeDataFromDatabase(nodeId: String, isFavourite: Bool) {
        let nodeRef = ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").child(nodeId)
        
        nodeRef.removeValue { error, _ in
            if let error = error {
                print("Failed to remove data: \(error)")
            } else {
                print("Data removed successfully")
            }
        }
        self.updateEvent(isFavourite: isFavourite, nodeId: nodeId)
        
    }
    
    func updateEvent(isFavourite: Bool, nodeId: String) {
        ref.child("Events").child(nodeId).updateChildValues(["isFavourite": isFavourite]) { error, _ in
            if let error = error {
                print("Failed to update data: \(error)")
            } else {
                print("Data updated successfully")
            }
        }
    }
    
}
