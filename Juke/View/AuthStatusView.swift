//
//  AuthStatusView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/22.
//

import SwiftUI

struct AuthStatusView: View {
    var user: User?
    
    var body: some View {
        HStack {
            Text(user != nil ? "Authorized" : "Not Authorized")
            switch user {
            case nil:
                SignInButton()
                NavigationLink("Log In", destination: LogInView())
            case .some(let user) where user.isAnonymous:
                SignOutButton()
            case .some(_):
                EmptyView()
            }
        }
    }
}

struct SignInButton: View {
    @EnvironmentObject private var action: SignInAction
    
    var body: some View {
        Button("Create User") {
            action.execute()
        }.disabled(action.isExecuting)
    }
}

struct SignOutButton: View {
    @EnvironmentObject private var action: SignOutAction
    
    var body: some View {
        Button("Sign Out") {
            action.execute()
        }
    }
}

struct AuthStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            AuthStatusView(user: nil)
            AuthStatusView(user: User(uid: "", isAnonymous: true))
            AuthStatusView(user: User(uid: "", isAnonymous: false))
        }.environmentObject(SignInAction.shared)
        .environmentObject(SignOutAction.shared)
    }
}
