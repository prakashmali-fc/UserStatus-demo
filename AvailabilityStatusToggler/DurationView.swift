//
//  DurationView.swift
//  Popupnavigation
//
//  Created by Vikas on 18/05/23.
//

import SwiftUI

enum MeetingViewAction {
    case backButton, doneButton
}

struct DurationView: View {
    
    @State var selectedDate: Date = .now
    @State var isEditable: Bool = true
    @Binding var statusInfo: UserStatus
    var completion: ((_ action: MeetingViewAction) -> Void)
    
    private var showDatePicker: Bool {
        statusInfo.duration == .custom
    }
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                NavigationHeader(statusInfo: $statusInfo, isEditable: $isEditable, didTapBackButton: { action in
                    switch action {
                    case .beginEditing:
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                            updateStatusDuration(.none)
                        }
                    case .backButton:
                        isEditable = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.35) {
                            completion(.backButton)
                        }
                    }
                })
                .padding(.bottom, 22)
                
                Text("Not taking calls until")
                    .font(.custom(AppFont.latoNormal.rawValue, size: 15).weight(.medium))
                    .foregroundColor(.availabilitysubTitle)
                    .padding(.bottom, 16)
                
                VStack(spacing: 9) {
                    if let status = statusInfo.selectedStatus  {
                        ForEach(status.options, id: \.self) { duration in
                            BreakTimeView(
                                title: duration.title,
                                isSelected: statusInfo.duration == duration,
                                didSelectDuration: {
                                    updateStatusDuration(duration)
                                    isEditable = false
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
                            .onAppear {
                                isEditable = false
                            }
                        }
                    }
                }
                .padding(.bottom, 25)
                
                Button {
                    withAnimation {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                            isEditable = false
                            completion(.doneButton)
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
                .padding(.bottom, 24)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.all, 24)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, 25)
            .animation(.easeInOut.speed(1), value: isEditable)
        }
    }
}

extension DurationView {
    func updateStatusDuration(_ duration: Duration) {
        statusInfo.duration = duration
    }
}
