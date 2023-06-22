//
//  PopupView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 22.06.2023.
//

import SwiftUI

struct PopupView: View {
    let popupText: String
    
    var body: some View {
        Text(popupText)
            .foregroundColor(.white)
            .frame(width: 300, height: 60)
            .background(.red)
            .cornerRadius(10)
            .padding(.bottom, 30)
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(popupText: "Something went wrong")
    }
}
