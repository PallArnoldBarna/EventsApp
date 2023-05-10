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
    static let imageSize = 100
}

enum SmallCardSizes {
    static let cardSize = 120
    static let imageSize = 50
}

struct HomePageView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showSideMenu = false
    @AppStorage("key") var darkMode: Bool = false
    @State private var showingPopup = false
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
                    if isDataLoaded {
                        ProgressView()
                    } else {
                        Text("You are logged in, \(loginViewModel.username)")
                    }
                    VStack {
                        HStack {
                            NavigationLink(destination: EventListView()) {
                                CardView(cardWidth: CGFloat(BigCardSizes.cardSize), cardHeight: CGFloat(BigCardSizes.cardSize), cardColor: .red, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: CGFloat(BigCardSizes.imageSize), cardImageHeight: CGFloat(BigCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            }
                            
                            VStack() {
                                CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .blue, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                                CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .yellow, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            }
                        }
                        HStack() {
                            CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .orange, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            
                            CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .green, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
                            
                            CardView(cardWidth: CGFloat(SmallCardSizes.cardSize), cardHeight: CGFloat(SmallCardSizes.cardSize), cardColor: .purple, vStackSpacing: 10, cardImageString: "globe", cardImageWidth: CGFloat(SmallCardSizes.imageSize), cardImageHeight: CGFloat(SmallCardSizes.imageSize), cardImageColor: .white, cardText: "All events", cardTextColor: .white)
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
