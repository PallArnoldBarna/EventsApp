//
//  EventRowView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 24.06.2023.
//

import SwiftUI

struct EventRowView: View {
    @State var event: Event
    @State var startDateString: String?
    @State var endDateString: String?
    
    var body: some View {
        HStack {
            Image(uiImage: (event.image.imageFromBase64 ?? UIImage(systemName: "x.circle.fill"))!)
                .resizable()
                .scaledToFit()
                .frame(width: 50.0, height: 50.0, alignment: .center)
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                Text("\(startDateString ?? "Unavailable") - \(endDateString ?? "Unavailable")")
                    .onAppear {
                        convertDateToString()
                    }
            }
            Spacer()
        }
    }
    
    func convertDateToString() {
        let startDate = event.startDate
        let endDate = event.endDate
        
        startDateString = startDate.convertToString()
        endDateString = endDate.convertToString()
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: Event(name: "Test", description: "Test", startDate: Date(), endDate: Date(), image: "", longitude: 123, latitude: 456, category: "Sport"))
    }
}
