//
//  Service.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import Foundation
import Combine

protocol Service {
    associatedtype Publisher: Combine.Publisher where Publisher.Failure == Never
    var publisher: Publisher { get }
}
