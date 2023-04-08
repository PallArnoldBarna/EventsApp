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
            ContentView()
                .environmentObject(loginViewModel)
                .environmentObject(signUpViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
