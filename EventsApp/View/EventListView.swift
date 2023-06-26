//
//  EventListView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 08.04.2023.
//

import SwiftUI

struct EventListView: View {
    let eventType: String
    @State var tabIndex = 1
    @EnvironmentObject var getEventsViewModel: GetEventsViewModel
    
    var body: some View {
        VStack{
            CustomTopTabBar(tabIndex: $tabIndex)
            if tabIndex == 0 {
                if eventType == "All events" {
                    List(filteredEventsPrevious, id: \.name) { event in
                        ZStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            EventRowView(event: event)
                        }
                    }
                    .listStyle(.inset)
                } else if eventType != "All events" {
                    List(filteredEventsPreviousByType, id: \.name) { event in
                        ZStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            EventRowView(event: event)
                        }
                    }
                    .listStyle(.inset)
                }
            }
            else if tabIndex == 1 {
                if eventType == "All events" {
                    List(filteredEventsCurrent, id: \.name) { event in
                        ZStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            EventRowView(event: event)
                        }
                    }
                    .listStyle(.inset)
                } else if eventType != "All events" {
                    List(filteredEventsCurrentByType, id: \.name) { event in
                        ZStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            EventRowView(event: event)
                        }
                    }
                    .listStyle(.inset)
                }
            }
            else if tabIndex == 2 {
                if eventType == "All events" {
                    List(filteredEventsUpcoming, id: \.name) { event in
                        ZStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            EventRowView(event: event)
                        }
                    }
                    .listStyle(.inset)
                } else if eventType != "All events" {
                    List(filteredEventsUpcomingByType, id: \.name) { event in
                        ZStack {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            
                            EventRowView(event: event)
                        }
                    }
                    .listStyle(.inset)
                }
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
        .padding(.horizontal, 12)
        .navigationBarTitle(eventType, displayMode: .inline)
    }
    
    var filteredEventsPrevious: [Event] {
        let currentDate = Date()
        
        return getEventsViewModel.events.filter {
            let itemDay = Calendar.current.component(.day, from: $0.endDate)
            let currentDay = Calendar.current.component(.day, from: currentDate)
            return itemDay < currentDay
        }
    }
    
    var filteredEventsPreviousByType: [Event] {
        return filteredEventsPrevious.filter {
            $0.category == eventType
        }
    }
    
    var filteredEventsCurrent: [Event] {
        let currentDate = Date()
        
        return getEventsViewModel.events.filter {
            let itemDay = Calendar.current.component(.day, from: $0.startDate)
            let currentDay = Calendar.current.component(.day, from: currentDate)
            return itemDay == currentDay
        }
    }
    
    var filteredEventsCurrentByType: [Event] {
        return filteredEventsCurrent.filter {
            $0.category == eventType
        }
    }
    
    var filteredEventsUpcoming: [Event] {
        let currentDate = Date()
        
        return getEventsViewModel.events.filter {
            let itemDay = Calendar.current.component(.day, from: $0.startDate)
            let currentDay = Calendar.current.component(.day, from: currentDate)
            return itemDay > currentDay
        }
    }
    
    var filteredEventsUpcomingByType: [Event] {
        return filteredEventsUpcoming.filter {
            $0.category == eventType
        }
    }
    
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(eventType: "All events")
    }
}
