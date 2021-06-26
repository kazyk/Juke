//
//  Context.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import Foundation

class Context {
    let signInAction = SignInAction()
    let signOutAction = SignOutAction()
    
    let userAuthStateListener = UserAuthStateListener()
    let libraryAuthorizationStatus = LibraryAuthorizationStatus()
    
    private(set) lazy var userAuthorization = UserAutherization(context: self)
    private(set) lazy var libraryAuthorization = LibraryAuthorization(context: self)
}
