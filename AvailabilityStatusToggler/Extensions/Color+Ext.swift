//
//  Color+Ext.swift
//  StatusToggle
//
//  Created by Vikas on 08/05/23.
//

import SwiftUI

extension Color {

    private init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    private init(colorCoding: ColorCoding) {
        self.init(hex: colorCoding.rawValue)
    }
    
    static var titleColor: Color { Color(colorCoding: .titleColor) }
    static var subTitleColor: Color { Color(colorCoding: .subTitleColor) }
    static var shadowColor: Color { Color(colorCoding: .shadowColor) }
    static var gradientTop: Color { Color(colorCoding: .gradientTop) }
    static var gradientBottom: Color { Color(colorCoding: .gradientBottom) }
    static var gradientOrange: Color { Color(colorCoding: .gradientOrange) }
    static var closeButtonColor: Color { Color(colorCoding: .closeButton) }
    static var availabilityTitle: Color { Color(colorCoding: .availabilityTitle) }
    static var availabilitysubTitle: Color { Color(colorCoding: .availabilitysubTitle) }
    static var backgroundColor: Color { Color(colorCoding: .backgroundColor) }
    static var backgroundColor2: Color { Color(colorCoding: .backgroundColor2).opacity(0.1) }
    static var borderGreen: Color { Color(colorCoding: .borderGreen) }
    static var borderRed: Color { Color(colorCoding: .borderRed) }
    static var borderBlue: Color { Color(colorCoding: .borderBlue) }
    static var blurBackground: Color { Color(colorCoding: .blurBackground) }
    
    private enum ColorCoding: String {
        case titleColor = "#4A4A4A"
        case subTitleColor = "#97A2B3"
        case shadowColor = "#00000010"
        case gradientTop = "#435470"
        case gradientBottom = "#202A3D"
        case gradientOrange = "#F18200"
        case closeButton = "#727C8F"
        case availabilityTitle = "#142640"
        case availabilitysubTitle = "#8495B1"
        case backgroundColor = "#F6F8FC"
        case backgroundColor2 = "#A8B6C8"
        case borderGreen = "#19AF72"
        case borderRed = "#DD2727"
        case borderBlue = "#6285FF"
        case blurBackground = "#020B2B4D"

    }
}
