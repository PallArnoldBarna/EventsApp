//
//  ModifyOrDeleteEventPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 30.06.2023.
//

import SwiftUI

struct ModifyOrDeleteEventPageView: View {
    @State var event: Event
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
    @EnvironmentObject var modifyAndDeleteEventsViewModel: ModifyAndDeleteEventsViewModel
    @State private var showingPopup = false
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                VStack {
                    Text("Update event")
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
                        self.modifyAndDeleteEventsViewModel.fetchNodeIdForEventToUpdate(event: event)
                    }, label: {
                        Text("Update event")
                    })
                    .modifier(ButtonModifier())
                    .popup(isPresented: $showingPopup) {
                        PopupView(popupText: "Event updated successfully!", backgroundColor: .green)
                    }
                    customize: {
                        $0.autohideIn(2)
                            .type(.toast)
                            .position(.bottom)
                            .animation(.spring())
                            .closeOnTapOutside(true)
                    }
                    
                    Button(action: {
                        self.showAlert.toggle()
                    }, label: {
                        Text("Delete event")
                    })
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(.red)
                    .cornerRadius(45)
                    .alert(isPresented: $showAlert) {
                        return Alert(title: Text("Delete event"), message: Text("Do you want to delete this event?"), primaryButton: .destructive(Text("Delete")) {
                            self.modifyAndDeleteEventsViewModel.fetchNodeIdForEventToDelete(eventName: event.name)
                            presentationMode.wrappedValue.dismiss()
                        }, secondaryButton: .cancel(Text("Cancel")))
                    }
                }
                
                Spacer()
            }
            .onAppear {
                fillFields()
            }
        }
    }
    
    func fillFields() {
        name = event.name
        description = event.description
        startDate = event.startDate
        endDate = event.endDate
        selectedImage = event.image.imageFromBase64
        locationAddress = event.locationAddress
        selectedCategory = event.category
    }
}

struct ModifyOrDeleteEventPageView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyOrDeleteEventPageView(event: Event(name: "Test", description: "Lorem ", startDate: Date(), endDate: Date(), image: "app_icon", locationAddress: "Strada Livezeni, 41", category: "Sport"))
    }
}
