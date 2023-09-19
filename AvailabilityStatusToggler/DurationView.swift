//
//  DurationView.swift
//  Popupnavigation
//
//  Created by Vikas on 18/05/23.
//

import SwiftUI

enum DurationViewDismissAction { case back, done }

struct DurationView: View {
    
    @State var selectedDate: Date = .now
    @State var isCustomStatusTitleInvalid: Bool = false
    @Binding var status: UserStatus
    var completion: ((_ action: DurationViewDismissAction) -> Void)
    
    private var showDatePicker: Bool {
        status.selectedDuration == .custom
    }
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                NavigationHeader(status: $status, showError: $isCustomStatusTitleInvalid, didTapBackButton: { action in
                    switch action {
                    case .backButton:
                        if status.selectedDuration == .custom {
                            status.resetDurationSelection()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                completion(.back)
                            }
                        } else {
                            completion(.back)
                        }
                    default: break
                    }
                })
                .padding(.bottom, 22)
                
                Text("Not taking calls until")
                    .font(.custom(AppFont.latoNormal.rawValue, size: 15).weight(.medium))
                    .foregroundColor(.availabilitysubTitle)
                    .padding(.bottom, 16)
                
                VStack(spacing: 9) {
                    if let status = status.selectedStatus  {
                        ForEach(status.options, id: \.self) { duration in
                            BreakTimeView(
                                title: duration.title,
                                isSelected: self.status.selectedDuration == duration,
                                didSelectDuration: {
                                    withAnimation {
                                        self.status.updateSelectedStatusDuration(duration)
                                    }
                                }
                            )
                            .frame(height: 40)
                        }
                        
                        if showDatePicker {
                            DatePicker(selection: $selectedDate) {
                                
                            }
                            .datePickerStyle(.wheel)
                            .frame(height: 110)
                            .frame(minWidth: 290)
                            .clipped()
                            .padding(.top, 25)
                        }
                    }
                }
                .padding(.bottom, 15)
                
                Button {
                    withAnimation {
                        if status.selectedStatus != .custom || !status.customStatusTitle.isEmpty {
                            completion(.done)
                        } else {
                            isCustomStatusTitleInvalid = true
                        }
                    }
                } label: {
                    Text("Done")
                        .foregroundColor(.white)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.borderBlue)
                        .cornerRadius(6)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 5)
                
            }
            .padding(.all, 24)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 25)
            .animation(.easeInOut.speed(1))
        }
    }
}


//extension DurationView {
//    func isDurationValid() {
//        switch status.selectedDuration {
//
//        case .custom:
//            debugPrint("custom duration selected")
//        }
//    }
//}
