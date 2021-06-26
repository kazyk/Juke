//
//  ActionButton.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import SwiftUI

struct ActionButton<I, S, F, A: Action<I, S, F>, V: View>: View {
    @EnvironmentObject private var action: A
    
    var actionType: A.Type
    var input: I
    var view: (_ action: @escaping () -> Void) -> V
    
    var body: some View {
        view {
            action.execute(input: input)
        }.disabled(action.isExecuting)
    }
}

extension ActionButton where I == Void {
    init(actionType: A.Type, view: @escaping (_ action: @escaping () -> Void) -> V) {
        self.actionType = actionType
        self.view = view
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
