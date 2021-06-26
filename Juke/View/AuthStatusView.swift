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
                ActionButton(actionType: SignInAction.self) { action in
                    Button("Create User", action: action)
                }
                NavigationLink("Log In", destination: LogInView())
            case .some(let user) where user.isAnonymous:
                ActionButton(actionType: SignOutAction.self) { action in
                    Button("Sign Out", action: action)
                }
            case .some(_):
                ActionButton(actionType: SignOutAction.self) { action in
                    Button("Sign Out", action: action)
                }
            }
        }
    }
}

struct AuthStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            AuthStatusView(user: nil)
            AuthStatusView(user: User(uid: "", isAnonymous: true))
            AuthStatusView(user: User(uid: "", isAnonymous: false))
        }.environmentObject(SignInAction())
        .environmentObject(SignOutAction())
    }
}
