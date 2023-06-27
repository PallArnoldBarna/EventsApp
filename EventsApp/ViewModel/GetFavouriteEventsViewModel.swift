//
//  GetFavouriteEventsViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 26.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class GetFavouriteEventsViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    @Published var favouriteEvents: [Event] = []
    @Published var favouriteEventsCount: Int = 0
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        ref.child("Users").child(auth.currentUser?.uid ?? "Undefined").child("FavouriteEvents").observe(.value) { snapshot in
            var favouriteEvents: [Event] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let event = snapshot.value as? [String: Any] {
                    if let eventData = try? JSONSerialization.data(withJSONObject: event),
                       let decodedEvent = try? JSONDecoder().decode(Event.self, from: eventData) {
                        favouriteEvents.append(decodedEvent)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.favouriteEvents = favouriteEvents
                self.favouriteEventsCount = favouriteEvents.count
            }
        }
    }
    
}
