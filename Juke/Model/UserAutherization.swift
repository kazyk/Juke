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
    
    static func from(firebaseUser: FirebaseAuth.User) -> User {
        User(uid: firebaseUser.uid, isAnonymous: firebaseUser.isAnonymous)
    }
}

class UserAutherization: Store<UserAutherization.State> {
    struct State {
        var user: User?
    }
    
    init(context: Context) {
        super.init(State())
        watch(context.userAuthStateListener) { state, user in
            state.user = user
        }
        watch(context.signInAction) { state, user in
            state.user = user
        }
        watch(context.signOutAction) { state, _ in
            state.user = nil
        }
    }
}


class SignInAction: Action<(), User, Error> {
    init() {
        super.init { _, completion in
            Auth.auth().signInAnonymously { result, err in
                if let err = err {
                    completion(.failure(err))
                    return
                }
                if let user = result?.user {
                    completion(.success(User.from(firebaseUser: user)))
                }
            }
        }
    }
}

class SignOutAction: Action<(), (), Error> {
    init() {
        super.init { _ in
            do {
                try Auth.auth().signOut()
                return .success(())
            } catch (let err) {
                return .failure(err)
            }
        }
    }
}

class UserAuthStateListener: Action<(), User?, Never> {
    init() {
        super.init { _, completion in
            Auth.auth().addStateDidChangeListener { _, user in
                completion(.success(user.flatMap(User.from(firebaseUser:))))
            }
        }
    }
}
