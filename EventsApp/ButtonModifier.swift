//
//  ButtonModifier.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 12.03.2023.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(.blue)
            .cornerRadius(45)
    }
}


