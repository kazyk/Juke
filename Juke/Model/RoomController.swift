//
//  RoomController.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/28.
//

import Foundation
import FirebaseFirestore
import Combine

struct Room {
    var uid: String
    var rid: String
}

final class RoomController: Store<RoomController.State> {
    struct State {
        var room: Room?
    }
    
    init(context: Context) {
        super.init(State())
        
        watch(context.createRoomAction) { state, room in
            state.room = room
        }
    }
}

final class CreateRoomAction: Action<User, Room, Error> {
    init() {
        super.init { user, completion in
            let doc = Firestore.firestore()
                .collection("rooms")
                .document()
            doc.setData([
                    "uid": user.uid,
                    "createdAt": FieldValue.serverTimestamp(),
                ], completion: { err in
                    if let err = err {
                        completion(.failure(err))
                    } else {
                        completion(.success(Room(uid: user.uid, rid: doc.documentID)))
                    }
                })
        }
    }
}
