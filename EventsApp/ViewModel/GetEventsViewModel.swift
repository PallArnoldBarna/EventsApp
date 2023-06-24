//
//  GetEventsViewModel.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 24.06.2023.
//

import Foundation
import Firebase
import FirebaseAuth

class GetEventsViewModel: ObservableObject {
    let auth = Auth.auth()
    let ref = Database.database().reference().child("Events")
    
    @Published var events: [Event] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        ref.observe(.value) { snapshot in
            var events: [Event] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let event = snapshot.value as? [String: Any] {
                    if let eventData = try? JSONSerialization.data(withJSONObject: event),
                       let decodedEvent = try? JSONDecoder().decode(Event.self, from: eventData) {
                        events.append(decodedEvent)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.events = events
            }
        }
    }
}
