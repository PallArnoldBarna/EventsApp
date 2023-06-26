//
//  HomePageView.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 11.03.2023.
//

import SwiftUI
import ExytePopupView

enum BigCardSizes {
    static let cardSize = 250
    static let imageSize = 125
}

enum SmallCardSizes {
    static let cardSize = 120
    static let imageSize = 50
}

struct HomePageView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showSideMenu = false
    @AppStorage("key") var darkMode: Bool = false
    @State private var isDataLoaded = false

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
                    VStack {
                        HStack {
                            NavigationLink(destination: EventListView(eventType: "All events")) {
                                CardView(cardWidth: CGFloat(BigCardSizes.cardSize), cardHeight: CGFloat(BigCardSizes.cardSize), cardColor: .red, vStackSpacing: 10, cardImageString: "globe_icon", cardImageWidth: CGFloat(BigCardSizes.imageSize), cardImageHeight: CGFloat(BigCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            }
                            
                            VStack() {
                                NavigationLink(destination: EventListView(eventType: "Party")) {
                                    CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .blue, vStackSpacing: 10, cardImageString: "party_icon", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "Party", cardTextColor: .white)
                                }
                                NavigationLink(destination: EventListView(eventType: "Festival")) {
                                    CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .yellow, vStackSpacing: 10, cardImageString: "festival_icon", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "Festival", cardTextColor: .white)
                                }
                            }
                        }
                        HStack() {
                            NavigationLink(destination: EventListView(eventType: "Conference")) {
                                CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .orange, vStackSpacing: 10, cardImageString: "conference_icon", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "Conference", cardTextColor: .white)
                            }
                            
                            NavigationLink(destination: EventListView(eventType: "Sport")) {
                                CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .green, vStackSpacing: 10, cardImageString: "sport_icon", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "Sport", cardTextColor: .white)
                            }
                            
                            NavigationLink(destination: EventListView(eventType: "Cultural")) {
                                CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .purple, vStackSpacing: 10, cardImageString: "cultural_icon", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "Cultural", cardTextColor: .white)
                            }
                        }
                    }
                    
                    Spacer()
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
