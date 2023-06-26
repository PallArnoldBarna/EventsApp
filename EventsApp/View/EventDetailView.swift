//
//  EventDetailView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 24.06.2023.
//

import SwiftUI
import ExytePopupView
import MapKit

struct EventDetailView: View {
    @State var event: Event
    @State var startDateString: String?
    @State var endDateString: String?
    @State var favouriteButtonPressed = false
    @EnvironmentObject var addAndRemoveFavouriteEventsViewModel: AddAndRemoveFavouriteEventsViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image(uiImage: (event.image.imageFromBase64 ?? UIImage(systemName: "x.circle.fill"))!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400, alignment: .center)
                    .padding(.bottom, 25)
                HStack {
                    Text(event.name)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Button(action: {
                        event.isFavourite.toggle()
                        self.favouriteButtonPressed.toggle()
                        if event.isFavourite == true {
                            self.addAndRemoveFavouriteEventsViewModel.fetchNodeIdForEvent(event: event)
                        }
                        else if event.isFavourite == false {
                            self.addAndRemoveFavouriteEventsViewModel.fetchNodeIdForFavouriteEvent(event: event)
                        }
                    }, label: {
                        Image(systemName: event.isFavourite ? "star.fill" : "star")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.yellow)
                            .frame(width: 30.0, height: 30.0, alignment: .center)
                            .padding(.trailing, 10)
                    })
                    .popup(isPresented: $favouriteButtonPressed) {
                        if event.isFavourite {
                            PopupView(popupText: "Event added to favorites!", backgroundColor: .green)
                        } else {
                            PopupView(popupText: "Event removed from favorites", backgroundColor: .red)
                        }
                    } customize: {
                        $0.autohideIn(1)
                            .type(.toast)
                            .position(.bottom)
                            .animation(.spring())
                            .closeOnTapOutside(true)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                VStack(alignment: .leading) {
                    HStack(spacing: 1) {
                        Text("Category: ")
                        Text(event.category)
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                    HStack(spacing: 1) {
                        Text("Start date: ")
                        Text(startDateString ?? "Unavailable")
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 1)
                    HStack(spacing: 1) {
                        Text("End date: ")
                        Text(endDateString ?? "Unavailable")
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                    Text(event.description)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 15)
                }
                .onAppear {
                    convertDateToString()
                }
                HStack {
                    Button(action: {
                        openMapWithCoordinates()
                    }, label: {
                        Text("Check the location")
                    })
                    .modifier(ButtonModifier())
                    .padding(.leading, 15)
                    Spacer()
                }
            }
        }
    }
    
    func convertDateToString() {
        let startDate = event.startDate
        let endDate = event.endDate
        
        startDateString = startDate.convertToString()
        endDateString = endDate.convertToString()
    }
    
    func openMapWithCoordinates() {
        let coordinates = "\(event.latitude),\(event.longitude)"
        let urlString = "maps://?q=\(coordinates)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: urlString ?? "") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: Event(name: "Test", description: "Lorem ", startDate: Date(), endDate: Date(), image: "app_icon", longitude: 123, latitude: 456, category: "Sport", isFavourite: true))
    }
}
