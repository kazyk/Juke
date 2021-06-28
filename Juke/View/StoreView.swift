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

struct StoreView2<S1, S2, V: View>: View {
    @EnvironmentObject private var context: Context
    let handler: (Context) -> (Store<S1>, Store<S2>)
    let makeView: (S1, S2) -> V
    
    init(_ handler: @escaping (Context) -> (Store<S1>, Store<S2>), makeView: @escaping (S1, S2) -> V) {
        self.handler = handler
        self.makeView = makeView
    }

    var body: some View {
        let stores = handler(context)
        StoreViewInner2(store1: stores.0, store2: stores.1) { (state1, state2) in
            makeView(state1, state2)
        }
    }
}

private struct StoreViewInner2<S1, S2, V: View>: View {
    @ObservedObject var store1: Store<S1>
    @ObservedObject var store2: Store<S2>
    var makeView: (S1, S2) -> V
    
    var body: some View {
        makeView(store1.state, store2.state)
    }
}
