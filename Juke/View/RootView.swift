//
//  RootView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var userAuth: UserAutherization
    
    var body: some View {
        NavigationView {
            HStack {
                AuthStatusView(user: userAuth.state.user)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
