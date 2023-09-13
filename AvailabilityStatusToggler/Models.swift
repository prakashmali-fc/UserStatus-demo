//
//  Models.swift
//  AvailabilityStatusToggler
//
//  Created by Vikas on 13/06/23.
//

import Foundation
import SwiftUI

enum UserStatusType: String, CaseIterable, Identifiable {
    
    case available
    case unAvailable
    case meeting
    case lunch
    case vacation
    case custom
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .available:
            return "I'm Available"
        case .unAvailable:
            return "I'm Unavailable"
        case .meeting:
            return "In a Meeting"
        case .lunch:
            return "At Lunch"
        case .vacation:
            return "On Vacation"
        case .custom:
            return "Custom"
        }
    }
    
    var subTitle: String {
        switch self {
        case .available:
            return "I can take calls"
        case .unAvailable:
            return "Not taking calls"
        case .meeting, .lunch, .vacation, .custom:
            return "Not taking calls until \(self.rawValue)"
        }
    }
    
    var navTitle: String {
        switch self {
        case .meeting:
            return "In a Meeting"
        case .lunch:
            return "Lunch"
        case .vacation:
            return "Vacation"
        default:
            return ""
        }
    }
    
    static func isvalidOption(option: Duration) -> Bool {
        return option != .none && option != .untilFurtherNotice
    }
    
    var options: [Duration] {
        switch self {
        case .available, .unAvailable:
            return []
        case .meeting, .custom:
            return [.untilFurtherNotice, .forAnHour, .forTwoHours, .custom]
        case .lunch:
            return [._15Minutes, ._30Minutes, ._60Minutes, .custom]
        case .vacation:
            return [._1Day, ._2Days, ._1Week, .custom]
        }
    }
    
    var color: Color {
        switch self {
        case .available:
            return Color.borderGreen
        case .unAvailable,.meeting, .lunch, .vacation, .custom:
            return Color.borderRed
        }
    }
    
    var icon: String {
        switch self {
        case .available:
            return Images.available.rawValue
        case .unAvailable, .meeting, .lunch, .vacation, .custom:
            return Images.unavailable.rawValue
        }
    }
}

enum Duration: String, Identifiable {
    
    case untilFurtherNotice, forAnHour, forTwoHours
    case _15Minutes, _30Minutes, _60Minutes
    case _1Day, _2Days, _1Week
    case none, custom
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .untilFurtherNotice:
            return "Until Further Notice"
        case .forAnHour:
            return "For an Hour"
        case .forTwoHours:
            return "For 2 Hours"
        case .custom :
            return "Custom"
        case ._15Minutes:
            return "15 minutes"
        case ._30Minutes:
            return "30 minutes"
        case ._60Minutes:
            return "60 minutes"
        case ._1Day:
            return "1 Day"
        case ._2Days:
            return "2 Day"
        case ._1Week:
            return "1 Week"
        case .none:
            return ""
        }
    }
    
    var duration: Int {
        switch self {
        case .custom, .untilFurtherNotice, .none:
            return 0
        case .forAnHour, ._60Minutes:
            return 60
        case .forTwoHours:
            return 120
        case ._15Minutes:
            return 15
        case ._30Minutes:
            return 30
        case ._1Day:
            return 1440
        case ._2Days:
            return 2880
        case ._1Week:
            return 10080
        }
    }
    
    static func getTitle(forDuration date: Date = Date(), for option: Duration) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let calendar = Calendar.current
        let durationToAdd = option.duration
        switch option {
        case ._1Day, ._2Days, ._1Week:
            dateFormatter.dateFormat = "MMM dd YYYY"
        default: break
        }
        let modifiedDate = calendar.date(byAdding: .minute, value: durationToAdd, to: date)
        if let modifiedDate {
            let dateStr = dateFormatter.string(from: modifiedDate)
            return (option == .none || option == .untilFurtherNotice) ? "Not taking calls" : "Not available until \(dateStr)"
        } else {
           return nil
        }
    }
}


struct UserStatus: Equatable {
    var currentStatus = UserStatusType.available
    var selectedStatus: UserStatusType? // for selecting purpose only
    var duration = Duration.untilFurtherNotice
    
    var customStatusTitle = ""
    var customDuration = Date()
    
    mutating func resetStatusSelection() {
        selectedStatus = nil
    }
}
