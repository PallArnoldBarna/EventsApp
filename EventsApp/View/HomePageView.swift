//
//  HomePageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI
import ExytePopupView

struct HomePageView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showSideMenu = false
    @AppStorage("key") var darkMode: Bool = false
    @State private var showingPopup = false
    @State private var isDataLoaded = true

    var body: some View {
        
        ZStack(alignment: .leading) {
            GeometryReaderCentered { _ in
                VStack {
                    ZStack {
                        HStack {
                            Button(action: {
                                withAnimation(.default) {
                                    self.showSideMenu.toggle()
                                }
                            }, label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            })
                            
                            Spacer()
                        }
                        Text("Home")
                            .font(.headline)
                    }
                    .padding()
                    .foregroundColor(.primary)

                    Spacer()
                    if isDataLoaded {
                        ProgressView()
                    } else {
                        Text("You are logged in, \(loginViewModel.username)")
                    }
                    VStack {
                        HStack {
                            NavigationLink(destination: FavouriteEventsPageView()) {
                                CardView(cardWidth: 210, cardHeight: 210, cardColor: .red, vStackSpacing: 25, cardImageString: "globe", cardImageWidth: 75, cardImageHeight: 75, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            }
                            
                            VStack(spacing: 10) {
                                CardView(cardWidth: 100, cardHeight: 100, cardColor: .blue, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: 25, cardImageHeight: 25, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                                CardView(cardWidth: 100, cardHeight: 100, cardColor: .yellow, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: 25, cardImageHeight: 25, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            }
                        }
                        HStack(spacing: 10) {
                            CardView(cardWidth: 100, cardHeight: 100, cardColor: .orange, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: 25, cardImageHeight: 25, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            
                            CardView(cardWidth: 100, cardHeight: 100, cardColor: .green, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: 25, cardImageHeight: 25, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            
                            CardView(cardWidth: 100, cardHeight: 100, cardColor: .purple, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: 25, cardImageHeight: 25, cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                        }
                    }
                    
                    Spacer()
                    Button(action: {
                        self.showingPopup.toggle()
                    }, label: {
                        Text("button")
                    })
                    .popup(isPresented: $showingPopup) {
                        Text("The popup")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 60)
                            .background(.green)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                    } customize: {
                        $0.autohideIn(2)
                            .type(.toast)
                            .position(.bottom)
                            .animation(.spring())
                            .closeOnTapOutside(true)
                    }
                }
                
            }
            
            HStack {
                SideMenuView(darkMode: self.$darkMode, showSideMenu: self.$showSideMenu)
                    .preferredColorScheme(self.darkMode ? .dark : .light)
                    .offset(x: self.showSideMenu ? 0 : -UIScreen.main.bounds.width / 1.5)
                
                Spacer(minLength: 0)
            }
            .background(Color.primary.opacity(self.showSideMenu ? (self.darkMode ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
            
                
        }
        .onAppear {
            loginViewModel.getUsername()
            DispatchQueue.main.async {
                self.isDataLoaded = false
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
