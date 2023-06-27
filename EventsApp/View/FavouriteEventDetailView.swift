//
//  FavouriteEventDetailView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 27.06.2023.
//

import SwiftUI
import ExytePopupView
import MapKit
import CoreLocation

struct FavouriteEventDetailView: View {
    @State var event: Event
    @State var startDateString: String?
    @State var endDateString: String?
    @State var favouriteButtonPressed = false
    @EnvironmentObject var addAndRemoveFavouriteEventsViewModel: AddAndRemoveFavouriteEventsViewModel
    @Environment(\.presentationMode) var presentationMode
    
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
                        self.favouriteButtonPressed = true
                        self.addAndRemoveFavouriteEventsViewModel.fetchNodeIdForFavouriteEvent(event: event)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 40.0, height: 40.0, alignment: .center)
                            .padding(.trailing, 10)
                    })
                    .disabled(favouriteButtonPressed)
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
        
        startDateString = startDate.convertToString()
        endDateString = endDate.convertToString()
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

struct FavouriteEventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteEventDetailView(event: Event(name: "Test", description: "Lorem ", startDate: Date(), endDate: Date(), image: "app_icon", locationAddress: "Strada Livezeni, 41", category: "Sport"))
    }
}
