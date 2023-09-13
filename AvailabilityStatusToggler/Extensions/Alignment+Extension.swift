//
//  Alignment+Extension.swift
//  StatusToggle
//
//  Created by Vikas on 09/05/23.
//

import SwiftUI

extension VerticalAlignment {
    //Setting the alignment of the view
    private enum TopAlign: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let topAlignment = VerticalAlignment(TopAlign.self)
}
