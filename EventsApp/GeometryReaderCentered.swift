//
//  GeometryReaderCentered.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 12.03.2023.
//

import SwiftUI

struct GeometryReaderCentered<Content: View>: View {
    var content: (GeometryProxy) -> Content

    var body: some View {
        GeometryReader { geometry in
            Group {
                content(geometry)
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center
            )
        }
    }
}


