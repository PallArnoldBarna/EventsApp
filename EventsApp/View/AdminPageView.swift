//
//  AdminPageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 01.04.2023.
//

import SwiftUI

struct AdminPageView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: AddEventPageView()) {
                HStack(spacing: 22) {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    
                    Text("Add new event")
                        .foregroundColor(.primary)
                }
                .padding(.leading, 30)
                Spacer()
            }
            .padding(.bottom, 25)
            
            NavigationLink(destination: AllEventsListView()) {
                HStack(spacing: 22) {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    
                    Text("Modify or delete event")
                        .foregroundColor(.primary)
                }
                .padding(.leading, 30)
                Spacer()
            }
            .padding(.bottom, 25)
            
            NavigationLink(destination: AddUserPageView()) {
                HStack(spacing: 22) {
                    Image(systemName: "person.fill.badge.plus")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.primary)
                    
                    Text("Add new user")
                        .foregroundColor(.primary)
                }
                .padding(.leading, 30)
                Spacer()
            }
            .padding(.bottom, 25)
            
            Spacer()
        }
        .padding(.top, 25)
        .navigationBarTitle("Admin page", displayMode: .inline)
    }
}

struct AdminPageView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPageView()
    }
}
