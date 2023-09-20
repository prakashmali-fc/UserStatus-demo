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
        
        VStack(spacing: 6) {
            availabilityText(
                with: statusType.title,
                font: .custom(AppFont.latoNormal.rawValue, size: 16).weight(.semibold),
                textColor: .availabilityTitle,
                statusColor: statusType.color
            )
            
            if statusType == .available {
                availabilityText(
                    with: statusType.subTitle,
                    font: .custom(AppFont.latoNormal.rawValue, size: 15).weight(.medium),
                    textColor: .availabilitysubTitle
                )
            }
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
    
    private func availabilityText(with title: String, font: Font, textColor: Color, statusColor: Color = .clear) -> some View {
        HStack(alignment: .center, spacing: 14) {
            BulletPoint(color: statusColor)
            getText(with: title, font: font, foregroundColor: textColor)
            Spacer()
        }
    }
}

extension View {
    func getText(with text: String, font: Font, foregroundColor: Color) -> some View {
        Text(text)
            .font(font)
            .foregroundColor(foregroundColor)
    }
}
