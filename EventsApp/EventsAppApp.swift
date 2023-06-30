//
//  EventsAppApp.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 10.03.2023.
//

import SwiftUI
import Firebase

@main
struct EventsAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let loginViewModel = LoginViewModel()
            let signUpViewModel = SignUpViewModel(loginViewModel: loginViewModel)
            let addEventViewModel = AddEventViewModel()
            let getEventsViewModel = GetEventsViewModel()
            let addAndRemoveFavouriteEventsViewModel = AddAndRemoveFavouriteEventsViewModel()
            let getFavouriteEventsViewModel = GetFavouriteEventsViewModel()
            let modifyUserDataViewModel = ModifyUserDataViewModel()
            let modifyAndDeleteEventViewModel = ModifyAndDeleteEventsViewModel()
            ContentView()
                .environmentObject(loginViewModel)
                .environmentObject(signUpViewModel)
                .environmentObject(addEventViewModel)
                .environmentObject(getEventsViewModel)
                .environmentObject(addAndRemoveFavouriteEventsViewModel)
                .environmentObject(getFavouriteEventsViewModel)
                .environmentObject(modifyUserDataViewModel)
                .environmentObject(modifyAndDeleteEventViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
