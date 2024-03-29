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
    @State var locationAddress = ""
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
                    
                    DatePicker("Start date", selection: $startDate)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    DatePicker("End date", selection: $endDate)
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
                    
                    TextField("Address", text: $locationAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    
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
                        let event = Event(name: name, description: description, startDate: startDate, endDate: endDate, image: imageBase64!, locationAddress: locationAddress, category: selectedCategory!)
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
