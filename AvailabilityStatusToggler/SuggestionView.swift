//
//  SuggestionView.swift
//  AvailabilityStatusToggler
//
//  Created by Vikas on 13/06/23.
//

import SwiftUI

// The text gets changes when user double taps the bottom toggle view
struct SuggestionView: View {
    
    var isEnabled: Bool = false
    var dismiss: (() -> Void)
    
    var body: some View {
        if isEnabled {
            VStack {
                Spacer()
                closeButton()
                HStack(alignment: .center ,spacing: 10) {
                    
                    BulletPoint(color: .gradientOrange)
                    
                    Text("Double tap on the status to quickly change your availability")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 125)
            }
            .background(
                HStack(alignment: .bottom) {
                    LinearGradient(colors: [Color.clear, Color.clear, .gradientBottom.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                }
            )
        }
    }
    
    func closeButton() -> some View {
        HStack {
            Spacer()
            if isEnabled {
                Button(action: dismiss) {
                    Text("Close")
                }
                .buttonStyle(SendButtonStyle())
            }
        }
        .padding(.trailing, 20)
        .padding(.bottom, 30)
    }
    
}

//struct SuggestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SuggestionView(circleColor: .gradientOrange, inputText: "This is the sample text we can provide as of now!!")
//            .background(Color.black.opacity(0.4))
//    }
//}

// Bullet point for the text
struct BulletPoint: View {
    
    var color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 9, height: 9)
    }
}

struct BulletPoint_Previews: PreviewProvider {
    static var previews: some View {
        BulletPoint(color: .red)
    }
}

// Cirular Raidus over Bottom Card Text
struct CircularRadius: View {
    var color: Color
    var body: some View {
        Circle()
            .fill(color.opacity(0.4))
            .frame(width: 25, height: 25)
            .background(
                Circle()
                    .fill(color.opacity(0.3))
                    .frame(width: 38, height: 38)
                    .background(
                        Circle()
                            .fill(color.opacity(0.15))
                            .frame(width: 50, height: 50)
                    )
            )
    }
}

struct CircularRadius_Previews: PreviewProvider {
    static var previews: some View {
        CircularRadius(color: .gradientOrange)
    }
}

// Button Style
struct SendButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center ,spacing: 5) {
            Image(Images.close.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 8, height: 8)
                .padding(.leading, 3)
            configuration.label
                .font(.custom(AppFont.latoNormal.rawValue, size: 12).weight(.medium))
                .foregroundColor(.closeButtonColor)
                
        }
        .padding(.horizontal, 6)
        .padding([.top,.bottom], 4)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
    }
}
