//
//  EventDetailView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 24.06.2023.
//

import SwiftUI

struct EventDetailView: View {
    @State var event: Event
    
    var body: some View {
        Text(event.name)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: Event(name: "Test", description: "Test", startDate: Date(), endDate: Date(), image: "", longitude: 123, latitude: 456, category: "Sport"))
    }
}
