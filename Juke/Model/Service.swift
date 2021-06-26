//
//  Service.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import Foundation
import Combine

protocol Service {
    associatedtype Value
    var publisher: AnyPublisher<Value, Never> { get }
}
