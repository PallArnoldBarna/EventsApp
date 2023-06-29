//
//  AllEventsListView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 30.06.2023.
//

import SwiftUI

struct AllEventsListView: View {
    @EnvironmentObject var getEventsViewModel: GetEventsViewModel
    @State private var reloadID = UUID()
    
    var body: some View {
        List(getEventsViewModel.events, id: \.name) { event in
            ZStack {
                NavigationLink(destination: ModifyOrDeleteEventPageView(event: event, reloadID: $reloadID)) {
                    EmptyView()
                }
                .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                
                EventRowView(event: event)
            }
        }
        .listStyle(.inset)
        .onAppear {
            getEventsViewModel.fetchData()
        }
    }
}

struct AllEventsListView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventsListView()
    }
}
