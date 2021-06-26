//
//  RootView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var userAuth: UserAutherization
    @EnvironmentObject private var libraryAuth: LibraryAuthorization
    
    var body: some View {
        NavigationView {
            VStack {
                AuthStatusView(user: userAuth.state.user)
                LibraryStatusView(status: libraryAuth.state.status)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
