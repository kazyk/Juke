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
        watch(context.loadRoomIdService) { state, roomid in
            if let roomid = roomid {
                state.room = Room(rid: roomid)
            }
        }
        effect(action: context.saveRoomIdAction) { state in
            if let room = state.room {
                return .execute(room.rid)
            }
            return .noop
        }
    }
}

final class CreateRoomAction: ActionBase<User, Room, Error> {
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
                        completion(.success(Room(rid: doc.documentID)))
                    }
                })
        }
    }
}

final class LoadRoomIdService: Service {
    let publisher = Deferred {
        return Just(UserDefaults.standard.string(forKey: "roomid"))
    }
}

final class SaveRoomIdAction: ActionBase<String, (), Error> {
    init() {
        super.init { roomId in
            UserDefaults.standard.setValue(roomId, forKey: "roomid")
            return .success(())
        }
    }
}
