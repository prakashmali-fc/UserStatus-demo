//
//  HeaderView.swift
//  AvailabilityStatusToggler
//
//  Created by Prakash on 13/09/23.
//

import SwiftUI

// Main Availablity view Header
struct HeaderView: View {
    
    @State var status: UserStatus
    var dismiss: (() -> Void)
    
    var body: some View {
        HStack(spacing: 10) {
            Image(status.currentStatus.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 35)
            
            UserStatusCardView(title: status.getStatusTitle(), subTitle: status.getStatusSubTitle())
                .transition(.opacity)
            
            Spacer()
            
            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                Image(Images.toggleup.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 10)
            }
        }
    }
}
