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
            Text(room?.rid ?? "")
            if let user = user, room == nil {
                ActionButton(actionType: CreateRoomAction.self, input: user) {
                    Button("Create Room", action: $0)
                }
            }
        }
    }
}

struct RoomStatusView_Previews: PreviewProvider {
    static var previews: some View {
        RoomStatusView()
    }
}
