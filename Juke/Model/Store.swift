//
//  Store.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/23.
//

import Foundation
import Combine

class Store<T>: ObservableObject {
    @Published private(set) var state: T
    
    private var sub = [AnyCancellable]()
    
    init(_ state: T) {
        self.state = state
    }
    
    func watch<A: ActionType>(_ action: A, handler: @escaping (inout T, A.Success) -> Void) {
        action.success.sink { [weak self] value in
            guard let self = self else {
                return
            }
            handler(&self.state, value)
        }.store(in: &sub)
    }
}
