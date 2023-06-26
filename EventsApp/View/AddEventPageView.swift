//
//  AddEventPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 23.06.2023.
//

import SwiftUI
import Combine

struct AddEventPageView: View {
    @State var name = ""
    @State var description = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State var longitude = ""
    @State var latitude = ""
    @State private var doubleValueLongitude: Double = 0.0
    @State private var doubleValueLatitude: Double = 0.0
    @State private var selectedCategory: String?
    let categories = [
        EventCategories.conference,
        EventCategories.cultural,
        EventCategories.festival,
        EventCategories.party,
        EventCategories.sport
    ]
    @EnvironmentObject var addNewEventViewModel: AddEventViewModel
    @State private var showingPopup = false
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                VStack {
                    Text("Add new event")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    TextField("Name", text: $name)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
                    DatePicker("Start date", selection: $startDate, displayedComponents: [.date])
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    DatePicker("End date", selection: $endDate, displayedComponents: [.date])
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Text("No image selected")
                    }
                    
                    Button("Select Image") {
                        isImagePickerPresented = true
                    }
                    
                    TextField("Latitude", text: $latitude)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .onReceive(Just(latitude)) { newValue in
                            let filtered = newValue.filter { "0123456789,.".contains($0) }
                            if filtered != newValue {
                                latitude = filtered
                            }
                        }
                    
                    TextField("Longitude", text: $longitude)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .onReceive(Just(longitude)) { newValue in
                            let filtered = newValue.filter { "0123456789,.".contains($0) }
                            if filtered != newValue {
                                longitude = filtered
                            }
                        }
                    
                }
                .padding()
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
                VStack {
                    Menu {
                        ForEach(categories, id: \.self) { option in
                            Button(action: {
                                selectedCategory = option
                            }) {
                                Text(option)
                            }
                        }
                    } label: {
                        Label(selectedCategory ?? "Select a category", systemImage: "chevron.down.circle")
                    }
                    .menuStyle(BorderlessButtonMenuStyle())
                    
                    Text("Selected category: \(selectedCategory ?? "")")
                        .padding()
                    
                    Button(action: {
                        self.showingPopup = true
                        let imageBase64 = selectedImage?.imageToBase64
                        guard let doubleLongitude = Double(longitude),
                              let doubleLatitude = Double(latitude) else {
                            return
                        }
                        doubleValueLongitude = doubleLongitude
                        doubleValueLatitude = doubleLatitude
                        let event = Event(name: name, description: description, startDate: startDate, endDate: endDate, image: imageBase64!, longitude: doubleValueLongitude, latitude: doubleValueLatitude, category: selectedCategory!, isFavourite: false)
                        addNewEventViewModel.addEventToDatabase(event: event)
                    }, label: {
                        Text("Add new event")
                    })
                    .modifier(ButtonModifier())
                    .popup(isPresented: $showingPopup) {
                        PopupView(popupText: "New event added successfully!", backgroundColor: .green)
                    }
                    customize: {
                        $0.autohideIn(2)
                            .type(.toast)
                            .position(.bottom)
                            .animation(.spring())
                            .closeOnTapOutside(true)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct AddEventPageView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventPageView()
    }
}
