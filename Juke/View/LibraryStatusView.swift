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
            Text("Library Access:")
            switch status {
            case .notDetermined:
                ActionButton({$0.requestLibraryAuthorizationAction}) {
                    Button("Request Access", action: $0)
                }
            case .denied:
                Text("Denied")
            case .authorized:
                Text("Granted")
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
        }.environmentObject(Context())
    }
}
