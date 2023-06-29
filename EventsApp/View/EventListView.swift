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
                    if filteredEventsPrevious.count == 0 {
                        Spacer()
                        Text("No previous events")
                    }
                    else {
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
                    }
                } else if eventType != "All events" {
                    if filteredEventsPreviousByType.count == 0 {
                        Spacer()
                        Text("No previous events")
                    }
                    else {
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
            }
            else if tabIndex == 1 {
                if eventType == "All events" {
                    if filteredEventsCurrent.count == 0 {
                        Spacer()
                        Text("No current events")
                    }
                    else {
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
                    }
                } else if eventType != "All events" {
                    if filteredEventsCurrentByType.count == 0 {
                        Spacer()
                        Text("No current events")
                    }
                    else {
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
            }
            else if tabIndex == 2 {
                if eventType == "All events" {
                    if filteredEventsUpcoming.count == 0 {
                        Spacer()
                        Text("No upcoming events")
                    }
                    else {
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
                    }
                } else if eventType != "All events" {
                    if filteredEventsUpcomingByType.count == 0 {
                        Spacer()
                        Text("No upcoming events")
                    }
                    else {
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
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
        .padding(.horizontal, 12)
        .navigationBarTitle(eventType, displayMode: .inline)
    }
    
    var filteredEventsPrevious: [Event] {
        return getEventsViewModel.events.filter {
            $0.endDate < Date()
        }
    }
    
    var filteredEventsPreviousByType: [Event] {
        return filteredEventsPrevious.filter {
            $0.category == eventType
        }
    }
    
    var filteredEventsCurrent: [Event] {
        return getEventsViewModel.events.filter {
            Calendar.current.isDateInToday($0.startDate)
        }
    }
    
    var filteredEventsCurrentByType: [Event] {
        return filteredEventsCurrent.filter {
            $0.category == eventType
        }
    }
    
    var filteredEventsUpcoming: [Event] {
        return getEventsViewModel.events.filter {
            $0.startDate > Date()
            
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
