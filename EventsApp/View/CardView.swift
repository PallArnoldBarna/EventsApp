//
//  CardView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 22.03.2023.
//

import SwiftUI

struct CardView: View {
    var cardWidth: CGFloat
    var cardHeight: CGFloat
    var cardColor: Color
    var vStackSpacing: CGFloat
    var cardImageString: String
    var cardImageWidth: CGFloat
    var cardImageHeight: CGFloat
    var cardImageColor: Color
    var cardText: String
    var cardTextColor: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: cardWidth, height: cardHeight)
                .foregroundColor(cardColor)
            VStack(spacing: vStackSpacing) {
                Image(systemName: cardImageString)
                    .resizable()
                    .frame(width: cardImageWidth, height: cardImageHeight)
                    .foregroundColor(cardImageColor)
                Text(cardText)
                    .foregroundColor(cardTextColor)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardWidth: 210, cardHeight: 210, cardColor: .red, vStackSpacing: 25, cardImageString: "globe", cardImageWidth: 75, cardImageHeight: 75, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
            .previewLayout(.sizeThatFits)
    }
}
