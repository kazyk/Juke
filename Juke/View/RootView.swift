//
//  RootView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            VStack {
                StoreView({$0.userAuthorization}) { state in
                    AuthStatusView(user: state.user)
                }
                StoreView({$0.libraryAuthorization}) { state in
                    LibraryStatusView(status: state.status)
                }
                StoreView2({($0.roomController, $0.userAuthorization)}) { roomState, userState in
                    RoomStatusView(room: roomState.room, user: userState.user)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
