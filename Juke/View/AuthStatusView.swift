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
                ActionButton(actionType: SignInAction.self) { executeAction in
                    Button("Create User", action: executeAction)
                }
                NavigationLink("Log In", destination: LogInView())
            case .some(let user) where user.isAnonymous:
                ActionButton(actionType: SignOutAction.self) { executeAction in
                    Button("Sign Out", action: executeAction)
                }
            case .some(_):
                ActionButton(actionType: SignOutAction.self) { executeAction in
                    Button("Sign Out", action: executeAction)
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
