//
//  AuthStatusView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import SwiftUI

struct AuthStatusView: View {
    @EnvironmentObject private var dispatcher: Dispatcher
    
    var user: User?
    
    var body: some View {
        HStack {
            Text(user != nil ? "Authorized" : "Not Authorized")
            switch user {
            case nil:
                SignInButton()
                NavigationLink("Log In", destination: LogInView())
            case .some(let user) where user.isAnonymous:
                Button("Log off", action: { })
            case .some(_):
                EmptyView()
            }
        }
    }
}

struct SignInButton: View {
    @ObservedObject private var action = SignInAction.shared
    
    var body: some View {
        Button("Create User") {
            action.execute()
        }.disabled(action.isExecuting)
    }
}

struct AuthStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            AuthStatusView(user: nil)
            AuthStatusView(user: User(uid: "", isAnonymous: true))
            AuthStatusView(user: User(uid: "", isAnonymous: false))
        }.environmentObject(Dispatcher.shared)
    }
}
