//
//  BreakTimeView.swift
//  AvailabilityStatusToggler
//
//  Created by Prakash on 13/09/23.
//

import SwiftUI

// MARK: - Breaks View
struct BreakTimeView: View {
    
    private var title: String
    private var isSelected: Bool
    private var didSelectDuration: (() -> Void)
    
    init(title: String, isSelected: Bool, didSelectDuration: @escaping (() -> Void)) {
        self.title = title
        self.isSelected = isSelected
        self.didSelectDuration = didSelectDuration
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 16))
            .fontWeight(isSelected ? .semibold : .medium)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(isSelected ? .borderBlue : .black)
            .background(isSelected ? .white : Color.backgroundColor2)
            .cornerRadius(8)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.borderBlue, lineWidth: 1.5)
                }
            }
            .onTapGesture {
                    didSelectDuration()
            }
    }
}
