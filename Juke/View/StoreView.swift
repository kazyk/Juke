//
//  StoreView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/28.
//

import SwiftUI

struct StoreView<S, V: View>: View {
    @EnvironmentObject private var context: Context
    let handler: (Context) -> Store<S>
    let makeView: (S) -> V
    
    init(_ handler: @escaping (Context) -> Store<S>, makeView: @escaping (S) -> V) {
        self.handler = handler
        self.makeView = makeView
    }

    var body: some View {
        StoreViewInner(store: handler(context)) { state in
            makeView(state)
        }
    }
}

private struct StoreViewInner<S, V: View>: View {
    @ObservedObject var store: Store<S>
    var makeView: (S) -> V
    
    var body: some View {
        makeView(store.state)
    }
}
