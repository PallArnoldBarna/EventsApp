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
            if getFavouriteEventsViewModel.favouriteEventsCount == 0 {
                Text("No favourite events")
            }
            else {
                List(getFavouriteEventsViewModel.favouriteEvents, id: \.name) { event in
                    ZStack {
                        NavigationLink(destination: FavouriteEventDetailView(event: event)) {
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
        .navigationBarTitle("Favourite events", displayMode: .inline)
        .onAppear{
            getFavouriteEventsViewModel.fetchData()
        }
    }
}

struct FavouriteEventsPageView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEventsPageView()
    }
}
