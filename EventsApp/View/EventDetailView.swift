//
//  EventDetailView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 24.06.2023.
//

import SwiftUI
import ExytePopupView
import MapKit
import CoreLocation

struct EventDetailView: View {
    @State var event: Event
    @State var startDateString: String?
    @State var endDateString: String?
    @State var favouriteButtonPressed = false
    @EnvironmentObject var addAndRemoveFavouriteEventsViewModel: AddAndRemoveFavouriteEventsViewModel
    @State private var isButtonEnabled = true
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image(uiImage: (event.image.imageFromBase64 ?? UIImage(systemName: "x.circle.fill"))!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 410, height: 300, alignment: .center)
                    .padding(.bottom, 25)
                HStack {
                    Text(event.name)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    Button(action: {
                        self.isButtonEnabled = false
                        self.favouriteButtonPressed = true
                        self.addAndRemoveFavouriteEventsViewModel.fetchNodeIdForEvent(event: event)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue)
                            .frame(width: 40.0, height: 40.0, alignment: .center)
                            .padding(.trailing, 10)
                    }
                    .disabled(!isButtonEnabled || favouriteButtonPressed)
                    .popup(isPresented: $favouriteButtonPressed) {
                        PopupView(popupText: "Event added to favourites!", backgroundColor: .green)
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
                        let address = event.locationAddress
                        
                        getCoordinate(from: address) { coordinate in
                            guard let coordinate = coordinate else {
                                return
                            }
                            
                            openMaps(with: coordinate)
                        }
                    }, label: {
                        Text("Check the location")
                    })
                    .modifier(ButtonModifier())
                    .padding(.leading, 15)
                }
            }
        }
        .navigationBarTitle(event.name, displayMode: .inline)
    }
    
    func convertDateToString() {
        let startDate = event.startDate
        let endDate = event.endDate
        
        startDateString = startDate.convertToString(dateFormat: "yyyy-MM-dd HH:mm")
        endDateString = endDate.convertToString(dateFormat: "yyyy-MM-dd HH:mm")
    }
    
    func getCoordinate(from address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            guard error == nil,
                  let placemark = placemarks?.first,
                  let location = placemark.location else {
                completion(nil)
                return
            }
            
            completion(location.coordinate)
        }
    }
    
    func openMaps(with coordinate: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = event.locationAddress
        
        mapItem.openInMaps(launchOptions: nil)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: Event(name: "Test", description: "Lorem ", startDate: Date(), endDate: Date(), image: "app_icon", locationAddress: "Strada Livezeni, 41", category: "Sport"))
    }
}
