//
//  File.swift
//  AvailabilityStatusToggler
//
//  Created by Prakash on 13/09/23.
//

import SwiftUI

// Title & subtitle for the bottom status card
struct UserStatusCardView: View {
    
    let status: UserStatus

    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            getText(with: getStatusTitle(), font: .custom(AppFont.latoNormal.rawValue, size: 16).weight(.heavy), foregroundColor: .titleColor) // font weight 600
            getText(with: getStatusSubTitle(), font: .custom(AppFont.latoNormal.rawValue, size: 14).weight(.light), foregroundColor: .subTitleColor)
        }
        .padding(.leading, 5)
    }
    
    func getText(with text: String, font: Font, foregroundColor: Color) -> some View{
        Text(text)
            .font(.custom(AppFont.latoNormal.rawValue, size: 14).weight(.light)) // font weight 400
            .foregroundColor(.subTitleColor)
    }
    
    func getStatusTitle() -> String {
        switch status.currentStatus {
        case .custom:
            return status.customStatusTitle
        default:
            return status.currentStatus.title
        }
    }
    
    func getStatusSubTitle() -> String {
        switch status.currentStatus {
        case .available:
            return status.currentStatus.subTitle
        default:
            let duration = status.duration
            if let subTitle = Duration.getTitle(
                forDuration: duration == .custom ? status.customDuration : Date(),
                for: status.duration
            ) {
                return subTitle
            }
            return status.duration.title
        }
    }
}
