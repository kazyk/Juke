//
//  UserAutherization.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/23.
//

import Foundation
import FirebaseAuth
import Combine

struct User {
    var uid: String
    var isAnonymous: Bool
}

class UserAutherization: ObservableObject {
    struct State {
        var user: User?
    }
    
    @Published private(set) var state = State()
    
    private var sub = [AnyCancellable]()
    
    init() {
        UserAuthStateListener.shared.success.sink { [weak self] user in
            self?.state.user = user
        }.store(in: &sub)
        SignInAction.shared.success.sink { [weak self] user in
            self?.state.user = user
        }.store(in: &sub)
    }
}


class SignInAction: Action<(), User, Error> {
    static let shared = SignInAction()
    
    init() {
        super.init { _, completion in
            Auth.auth().signInAnonymously { result, err in
                if let err = err {
                    completion(.failure(err))
                    return
                }
                if let user = result?.user {
                    completion(.success(User(uid: user.uid, isAnonymous: user.isAnonymous)))
                }
            }
        }
    }
}

class UserAuthStateListener: Action<(), User?, Never> {
    static let shared = UserAuthStateListener()
    
    init() {
        super.init { _, completion in
            Auth.auth().addStateDidChangeListener { _, user in
                completion(.success(user.flatMap({ u in
                    User(uid: u.uid, isAnonymous: u.isAnonymous)
                })))
            }
        }
    }
}
