//
//  Action.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import Foundation
import Combine

class Action<Input, Success, Failure: Error>: ObservableObject {
    @Published private(set) var isExecuting = false
    private let successSubject = PassthroughSubject<Success, Never>()
    private let errorSubject = PassthroughSubject<Failure, Never>()
    private var action: (Input, @escaping (Result<Success, Failure>) -> Void) -> Void
    
    init(_ action: @escaping (Input, @escaping (Result<Success, Failure>) -> Void) -> Void) {
        self.action = action
    }
    
    init(_ action: @escaping (Input) -> Result<Success, Failure>) {
        self.action = { (input, completion) in
            let result = action(input)
            completion(result)
        }
    }
    
    var success: AnyPublisher<Success, Never> {
        successSubject.eraseToAnyPublisher()
    }
    
    var errors: AnyPublisher<Failure, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    func execute(input: Input) {
        if isExecuting {
            return
        }
        isExecuting = true
        action(input) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let suc):
                self.successSubject.send(suc)
            case .failure(let err):
                self.errorSubject.send(err)
            }
            self.isExecuting = false
        }
    }
}

extension Action where Input == () {
    func execute() {
        execute(input: ())
    }
}
