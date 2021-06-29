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
        var isConnected = false
    }
    
    init(context: Context) {
        super.init(State())
        
        watch(context.createRoomAction) { state, room in
            state.room = room
            state.isConnected = true
        }
        watch(context.loadRoomIdService) { state, roomid in
            if let roomid = roomid {
                state.room = Room(rid: roomid)
            }
        }
        watch(context.leaveRoomAction) { state, _ in
            state.room = nil
            state.isConnected = false
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
                        UserDefaults.standard.setValue(doc.documentID, forKey: "roomid")
                        completion(.success(Room(rid: doc.documentID)))
                    }
                })
        }
    }
}

final class LeaveRoomAction: ActionBase<(), (), Error> {
    init() {
        super.init { _, completion in
            completion(.success(()))
        }
    }
}

final class LoadRoomIdService: Service {
    let publisher = Deferred {
        Future<String?, Never> { resolve in
            guard let rid = UserDefaults.standard.string(forKey: "roomid") else {
                resolve(.success(nil))
                return
            }
            let doc = Firestore.firestore().collection("rooms").document(rid)
            doc.getDocument(source: .server) { snapshot, err in
                if let snapshot = snapshot {
                    resolve(.success(rid))
                } else {
                    resolve(.success(nil))
                }
            }
        }
    }
}
