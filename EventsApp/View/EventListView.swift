//
//  EventListView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 08.04.2023.
//

import SwiftUI

struct EventListView: View {
    @State var tabIndex = 1
       
       var body: some View {
           VStack{
               CustomTopTabBar(tabIndex: $tabIndex)
               if tabIndex == 0 {
                   Spacer()
                   Text("First")
               }
               else if tabIndex == 1 {
                   Spacer()
                   Text("Second")
               }
               else if tabIndex == 2 {
                   Spacer()
                   Text("Third")
               }
               Spacer()
           }
           .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
           .padding(.horizontal, 12)
           .navigationBarTitle("All events", displayMode: .inline)
       }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
