//
//  AvailabilityView.swift
//  AvailabilityStatusToggler
//
//  Created by Prakash on 13/09/23.
//

import SwiftUI

// Main Availablity view status type
struct AvailabilityView: View {
    
    let statusType: UserStatusType
    var isSelected: Bool
    var didSelectStatus: (() -> Void)
    
    init(statusType: UserStatusType, isSelected: Bool = false, didSelectStatus: @escaping () -> Void) {
        self.statusType = statusType
        self.isSelected = isSelected
        self.didSelectStatus = didSelectStatus
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: statusType.subTitle.isEmpty ? 14 : 12) {
            
            BulletPoint(color: statusType.color)
                .offset(y: 4)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(statusType.title)
                    .font(.custom(AppFont.latoNormal.rawValue, size: 16).weight(.semibold))
                    .foregroundColor(.availabilityTitle)
                
                if statusType == .available { // show subtitle only for available
                    Text(statusType.subTitle)
                        .font(.custom(AppFont.latoNormal.rawValue, size: 15).weight(.medium))
                        .foregroundColor(.availabilitysubTitle)
                }
            }
            Spacer()
        }
        .padding(.all, !statusType.subTitle.isEmpty ? 15 : 13)
        .background(isSelected ? Color.white : Color.backgroundColor)
        .cornerRadius(8)
        .onTapGesture {
            didSelectStatus()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isSelected ? statusType.color : .clear,
                    lineWidth: !statusType.subTitle.isEmpty ? 1.5 : 1.0
                )
        )
    }
}
