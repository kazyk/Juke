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
    let context = Context()
    
    init() {
        FirebaseApp.configure()
        context.userAuthStateListener.execute()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(context.signInAction)
                .environmentObject(context.signOutAction)
                .environmentObject(context.userAuthorization)
        }
    }
}
