//
//  NavigationHeader.swift
//
//  Created by Vikas on 13/06/23.
//

import SwiftUI
import Introspect

// MARK: - Custom Navigation Header
enum NavigationHeaderAction { case beginEditing, backButton }

struct NavigationHeader: View {
    
    @Binding var status: UserStatus
    @Binding var showError: Bool
    
    var didTapBackButton: ((_ action: NavigationHeaderAction) -> Void)
    
    var placeHolder: Text {
        return showError
        ? Text("Provide custom status").foregroundColor(.red)
        : Text("Add a custom title").foregroundColor(.gray.opacity(0.6))
    }
    
    var enableKeyboard: Bool {
        return status.selectedStatus == .custom && status.selectedDuration != .custom
    }
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 9, height: 10)
                .padding(.trailing, 10)
                .onTapGesture {
                    withAnimation {
                        showError = true
                        didTapBackButton(.backButton)
                    }
                }
            BulletPoint(color: .red)
                .padding(.trailing, 5)
            
            if let status = status.selectedStatus, status != .custom {
                Text(status.navTitle)
                    .frame(height: 22)
            } else {
                TextField("", text: $status.customStatusTitle)
                    .introspectTextField(customize: handleKeyboard(_:))
                    .background(placeHolder.frame(maxWidth: .infinity, alignment: .leading))
                    .font(.system(size: 18))
                    .onTapGesture {
                        showError = false
                    }
            }
            Spacer()
        }
    }
    
    func handleKeyboard(_ tf: UITextField) {
        if enableKeyboard && !showError {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                tf.becomeFirstResponder()
            }
        } else {
            DispatchQueue.main.async {
                tf.resignFirstResponder()
            }
        }
    }
}
