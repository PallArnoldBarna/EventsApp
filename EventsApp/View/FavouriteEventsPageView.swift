//
//  FavouriteEventsPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 20.03.2023.
//

import SwiftUI

struct FavouriteEventsPageView: View {
    @EnvironmentObject var getFavouriteEventsViewModel: GetFavouriteEventsViewModel
    
    var body: some View {
        VStack {
            List(getFavouriteEventsViewModel.favouriteEvents, id: \.name) { event in
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

struct FavouriteEventsPageView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEventsPageView()
    }
}
