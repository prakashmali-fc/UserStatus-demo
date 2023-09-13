//
//  NavigationHeader.swift
//  AvailabilityStatusToggler
//
//  Created by Prakash on 13/09/23.
//

import SwiftUI
import Introspect

// MARK: - Custom Navigation Header
enum NavigationHeaderAction { case beginEditing, backButton }

struct NavigationHeader: View {
    
    @Binding var statusInfo: UserStatus
    @Binding var isEditable: Bool
    var didTapBackButton: ((_ action: NavigationHeaderAction) -> Void)
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .resizable()
                .scaledToFit()
                .frame(width: 9, height: 10)
                .padding(.trailing, 10)
                .onTapGesture {
                    withAnimation {
                        didTapBackButton(.backButton)
                    }
                }
            BulletPoint(color: .red)
                .padding(.trailing, 5)
            
            if let status = statusInfo.selectedStatus, status != .custom{
                Text(status.navTitle)
                    .frame(height: 22)
            } else {
                TextField("", text: $statusInfo.customStatusTitle, prompt: Text("Add a custom title") .foregroundColor(.gray.opacity(0.6)))
                    .introspectTextField(customize: { textfield in
                        if isEditable {
                            didTapBackButton(.beginEditing)
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: {
                                textfield.becomeFirstResponder()
                            })
                        } else {
                            DispatchQueue.main.async {
                                textfield.resignFirstResponder()
                            }
                        }

                    })
                    .font(.system(size: 18))
//                    .onTapGesture {
//                        withAnimation {
//                            didTapBackButton(.beginEditing)
//                        }
//                    }
            }
            Spacer()
        }
    }
}
