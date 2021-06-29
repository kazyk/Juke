//
//  Context.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import Foundation

class Context: ObservableObject {
    let signInAction = SignInAction()
    let signOutAction = SignOutAction()
    let requestLibraryAuthorizationAction = RequestLibraryAuthorizationAction()
    let createRoomAction = CreateRoomAction()
    let leaveRoomAction = LeaveRoomAction()
    
    let userAuthStateListener = UserAuthStateListener()
    let libraryAuthorizationStatus = LibraryAuthorizationStatus()
    let loadRoomIdService = LoadRoomIdService()
    
    private(set) lazy var userAuthorization = UserAutherization(context: self)
    private(set) lazy var libraryAuthorization = LibraryAuthorization(context: self)
    private(set) lazy var roomController = RoomController(context: self)
}
