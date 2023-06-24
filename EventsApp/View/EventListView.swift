//
//  EventListView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 08.04.2023.
//

import SwiftUI

struct EventListView: View {
    let navbarTitle: String
    @State var tabIndex = 1
    @EnvironmentObject var getEventsViewModel: GetEventsViewModel
       
       var body: some View {
           VStack{
               CustomTopTabBar(tabIndex: $tabIndex)
               if tabIndex == 0 {
                   Spacer()
                   Text("First")
               }
               else if tabIndex == 1 {
                   List(getEventsViewModel.events, id: \.name) { event in
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
               else if tabIndex == 2 {
                   Spacer()
                   Text("Third")
               }
               Spacer()
           }
           .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
           .padding(.horizontal, 12)
           .navigationBarTitle(navbarTitle, displayMode: .inline)
       }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(navbarTitle: "All events")
    }
}
