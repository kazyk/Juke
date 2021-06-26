//
//  LibraryStatusView.swift
//  Juke
//
//  Created by kazuyuki takahashi on 2021/06/26.
//

import SwiftUI

struct LibraryStatusView: View {
    var status: LibraryAuthorization.Status
    
    var body: some View {
        HStack {
        switch status {
        case .notDetermined:
            Text("No Access")
            ActionButton(actionType: RequestLibraryAuthorizationAction.self) { action in
                Button("Request Access", action: action)
            }
        case .denied:
            Text("Access Denied")
        case .authorized:
            Text("Access Granted")
        }
        }
    }
}

struct LibraryStatusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LibraryStatusView(status: .notDetermined)
            LibraryStatusView(status: .denied)
            LibraryStatusView(status: .authorized)
        }.environmentObject(RequestLibraryAuthorizationAction())
    }
}
