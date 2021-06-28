//
//  ActionButton.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import SwiftUI

struct ActionButton<I, S, F, A: Action<I, S, F>, V: View>: View {
    @EnvironmentObject private var context: Context
    
    var action: (Context) -> A
    var input: I
    var view: (_ executeAction: @escaping () -> Void) -> V
    
    init(_ action: @escaping (Context) -> A, input: I, view: @escaping (@escaping () -> Void) -> V) {
        self.action = action
        self.input = input
        self.view = view
    }
    
    var body: some View {
        let a = action(context)
        view {
            a.execute(input: input)
        }.disabled(a.isExecuting)
    }
}

extension ActionButton where I == Void {
    init(_ action: @escaping (Context) -> A, view: @escaping (@escaping () -> Void) -> V) {
        self.action = action
        self.view = view
    }
}

