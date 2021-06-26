//
//  LibraryAuthorization.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import Foundation
import MediaPlayer
import Combine

final class LibraryAuthorization: Store<LibraryAuthorization.State> {
    enum Status {
        case notDetermined, authorized, denied
        
        fileprivate init(_ status: MPMediaLibraryAuthorizationStatus) {
            switch status {
            case .authorized, .restricted:
                self = .authorized
            case .denied:
                self = .denied
            case .notDetermined:
                self = .notDetermined
            @unknown default:
                self = .notDetermined
            }
        }
    }
    struct State {
        var status: Status = .notDetermined
    }
    
    init(initialState: State = State(), context: Context) {
        super.init(initialState)
        
        watch(context.libraryAuthorizationStatus) { state, status in
            state.status = status
        }
    }
}

final class RequestLibraryAuthorizationAction: Action<(), LibraryAuthorization.Status, Error> {
    init() {
        super.init { _, completion in
            MPMediaLibrary.requestAuthorization { status in
                completion(.success(.init(status)))
            }
        }
    }
}

final class LibraryAuthorizationStatus: Service {
    var publisher: AnyPublisher<LibraryAuthorization.Status, Never> {
        Deferred {
            Just(LibraryAuthorization.Status(MPMediaLibrary.authorizationStatus()))
        }.eraseToAnyPublisher()
    }
}
