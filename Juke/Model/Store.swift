//
//  Store.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/23.
//

import Foundation
import Combine

class Store<State>: ObservableObject {
    @Published private(set) var state: State
    
    private var sub = [AnyCancellable]()
    
    init(_ state: State) {
        self.state = state
    }
    
    // Watch successful results of action and update state
    func watch<A: Action>(_ action: A, handler: @escaping (inout State, A.Success) -> Void) {
        action.success.sink { [weak self] value in
            guard let self = self else {
                return
            }
            handler(&self.state, value)
        }.store(in: &sub)
    }
    
    // Watch successful values of service and update state
    func watch<S: Service>(_ service: S, handler: @escaping (inout State, S.Publisher.Output) -> Void) {
        service.publisher
            .sink { [weak self] value in
                guard let self = self else {
                    return
                }
                handler(&self.state, value)
            }.store(in: &sub)
    }
    
    enum EffectTrigger<T: Equatable> {
        case execute(T), noop
    }
    
    // Trigger side effect by state change
    func effect<A: Action>(action: A, when condition: @escaping (State) -> EffectTrigger<A.Input>) {
        var prevValue: A.Input?
        $state.sink { state in
            switch condition(state) {
            case .execute(let t):
                if prevValue != t {
                    action.execute(input: t)
                }
                prevValue = t
            case .noop:
                prevValue = nil
            }
        }.store(in: &sub)
    }
}
