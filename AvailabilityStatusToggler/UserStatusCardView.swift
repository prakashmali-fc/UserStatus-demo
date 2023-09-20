//
//  UserStatusCardView.swift
//
//  Created by Prakash on 13/09/23.
//

import SwiftUI

// Title & subtitle for the bottom status card
struct UserStatusCardView: View {
    
    let title: String
    let subTitle: String

    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            userStatusCard(
                with: title,
                font: .custom(AppFont.latoNormal.rawValue,
                size: 16).weight(.heavy),
                foregroundColor: .titleColor
            )
            userStatusCard(
                with: subTitle,
                font: .custom(AppFont.latoNormal.rawValue,
                size: 14).weight(.light),
                foregroundColor: .subTitleColor
            )
        }
        .padding(.leading, 5)
    }
    
    func userStatusCard(with text: String, font: Font, foregroundColor: Color) -> some View {
        Text(text)
            .font(font)
            .foregroundColor(foregroundColor)
    }
}
