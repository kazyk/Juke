//
//  Service.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/23.
//

import Foundation
import Combine

class Service<T> {
    private let subject = PassthroughSubject<T, Never>()
    
    var events: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }
    
    func send(_ event: T) {
        subject.send(event)
    }
}
