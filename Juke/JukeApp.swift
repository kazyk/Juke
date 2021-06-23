//
//  JukeApp.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import SwiftUI
import Firebase

@main
struct JukeApp: App {
    let userAuthorization = UserAutherization()
    
    init() {
        FirebaseApp.configure()
        UserAuthStateListener.shared.execute()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userAuthorization)
                .environmentObject(SignInAction.shared)
                .environmentObject(SignOutAction.shared)
        }
    }
}
