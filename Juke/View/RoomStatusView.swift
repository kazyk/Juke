//
//  RoomStatusView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/28.
//

import SwiftUI

struct RoomStatusView: View {
    var room: Room?
    var user: User?
    
    var body: some View {
        HStack {
            Text("Room:")
            if let user = user {
                if let room = room {
                    Text(room.rid)
                } else {
                    ActionButton({$0.createRoomAction}, input: user) {
                        Button("Create Room", action: $0)
                    }
                }
            } else {
                Text("Not authorized")
            }
        }
    }
}

struct RoomStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoomStatusView(room: nil, user: nil)
            RoomStatusView(room: nil, user: User(uid: "", isAnonymous: true))
            RoomStatusView(room: Room(rid: "rid"), user: User(uid: "", isAnonymous: true))
        }.environmentObject(Context())
    }
}
