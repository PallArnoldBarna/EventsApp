//
//  ModifyAndDeleteEventsViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 30.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class ModifyAndDeleteEventsViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    func fetchNodeIdForEventToUpdate(event: Event) {
        let query = ref.child("Events").queryOrdered(byChild: "name").queryEqual(toValue: event.name)
        
        query.observeSingleEvent(of: .value) { snapshot in
            guard let node = snapshot.children.allObjects.first as? DataSnapshot else {
                print("Data not found")
                return
            }
            
            self.updateEventData(eventNodeID: node.key, updatedData: event)
        }
    }
    
    func updateEventData(eventNodeID: String, updatedData: Event) {
        let encoder = JSONEncoder()
        guard let newDataDict = try? JSONSerialization.jsonObject(with: encoder.encode(updatedData), options: []) as? [String: Any] else {
            return
        }

        let eventsRef = ref.child("Events").child(eventNodeID)
        eventsRef.updateChildValues(newDataDict)

        let usersRef = ref.child("Users")
        usersRef.observeSingleEvent(of: .value) { snapshot in
            guard let usersData = snapshot.value as? [String: Any] else { return }

            for (userID, userData) in usersData {
                guard var userDict = userData as? [String: Any],
                    var favoriteEvents = userDict["FavouriteEvents"] as? [String: [String: Any]],
                    let favoriteEvent = favoriteEvents[eventNodeID]
                else { continue }

                favoriteEvents[eventNodeID] = favoriteEvent.merging(newDataDict) { (_, new) in new }
                userDict["FavouriteEvents"] = favoriteEvents

                let userRef = usersRef.child(userID)
                userRef.updateChildValues(userDict)
            }
        }
    }

    func fetchNodeIdForEventToDelete(eventName: String) {
        let query = ref.child("Events").queryOrdered(byChild: "name").queryEqual(toValue: eventName)
        
        query.observeSingleEvent(of: .value) { snapshot in
            guard let node = snapshot.children.allObjects.first as? DataSnapshot else {
                print("Data not found")
                return
            }
            
            self.deleteEvent(eventNodeID: node.key)
        }
    }
    
    func deleteEvent(eventNodeID: String) {
        let eventsRef = ref.child("Events").child(eventNodeID)
        eventsRef.removeValue()
        
        let usersRef = ref.child("Users")
        usersRef.observeSingleEvent(of: .value) { snapshot in
            guard let usersData = snapshot.value as? [String: Any] else { return }
            
            for (userID, userData) in usersData {
                guard var userDict = userData as? [String: Any],
                      var favoriteEvents = userDict["FavouriteEvents"] as? [String: Any]
                else { continue }
                
                if favoriteEvents[eventNodeID] != nil {
                    favoriteEvents.removeValue(forKey: eventNodeID)
                    userDict["FavouriteEvents"] = favoriteEvents
                    
                    let userRef = usersRef.child(userID)
                    userRef.updateChildValues(userDict)
                }
            }
        }
    }
}
