//
//  ActionButton.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import SwiftUI

struct ActionButton<A: Action & ObservableObject, V: View>: View {
    @EnvironmentObject private var context: Context
    
    var action: (Context) -> A
    var input: A.Input
    var view: (_ executeAction: @escaping () -> Void) -> V
    
    init(_ action: @escaping (Context) -> A, input: A.Input, view: @escaping (@escaping () -> Void) -> V) {
        self.action = action
        self.input = input
        self.view = view
    }
    
    var body: some View {
        ActionButtonInner(action: action(context), input: input, view: view)
    }
}

extension ActionButton where A.Input == Void {
    init(_ action: @escaping (Context) -> A, view: @escaping (@escaping () -> Void) -> V) {
        self.action = action
        self.view = view
    }
}

struct ActionButtonInner<A: Action & ObservableObject, V: View>: View {
    @ObservedObject var action: A
    var input: A.Input
    var view: (_ executeAction: @escaping () -> Void) -> V
    
    var body: some View {
        view {
            action.execute(input: input)
        }.disabled(action.isExecuting)
    }
}
