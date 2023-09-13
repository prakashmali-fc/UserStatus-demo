//
//  UserStatusView.swift
//  AvailabilityStatusToggler
//
//  Created by Vikas on 13/06/23.
//

import SwiftUI

struct UserStatusView: View {
    
    // Properties
    @State var enableSuggestionView: Bool = false
    @State var enableMeetingView: Bool = false
    @State var inputTitle: String = ""
    @Binding var showStatusSelection: Bool
    @Binding var status: UserStatus
    
    var allAvailabilityStatuses = UserStatusType.allCases
    
    //Matched Geometry
    @Namespace private var namespace
    private var namespaceID: String = "card"
    // Disable geometry when transition
    @State var disableGeometryEffect: Bool = false
    
    init(showStatusSelection: Binding<Bool>, status: Binding<UserStatus>) {
        _showStatusSelection = showStatusSelection
        _status = status
    }
    
    var body: some View {
        ZStack {
            if !showStatusSelection {
               Suggestionview
            } else {
                popUpView()
            }// else end
        }// ZStack
    }
}

extension UserStatusView {
    
    var Suggestionview: some View {
        ZStack(alignment: .bottom) {
            SuggestionView(isEnabled: enableSuggestionView) {
                enableSuggestionView(false)
            }
            BottomStatusView() //Bottom status view
                .matchedGeometryEffect(id: namespaceID, in: namespace)
        }
        .animation(.easeIn.speed(1.5), value: showStatusSelection)
    }
    
    func BottomStatusView() -> some View {
        VStack {
            HStack(alignment: .center) {
                Image(status.currentStatus.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 35)
                    .padding(.leading, 8)
                
                UserStatusCardView(status: status)
                #warning("add the transition when changing the status for UserStatusCardView")
                
                Spacer()
                Image(Images.toggleDown.rawValue)
                    .resizable()
                    .frame(width: 15, height: 10, alignment: .center)
                    .padding(.trailing, 5)
                    .onTapGesture {
                        toggleStatusView(enablePopup: true)
                        disableGeometryEffect = false
                    }
            }
            .padding()
            .frame(height: 86)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
            .padding(.horizontal)
            
        }
        .gesture(
            TapGesture(count: 2) // Detect double tap gesture
                .onEnded {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        status.currentStatus = (status.currentStatus == .available) ? .unAvailable : .available
                    }
                }
        )
        .onTapGesture(count: 1) { // Detect single tap gesture
            withAnimation(.default) {
                enableSuggestionView(true)
            }
        }
        .padding(.bottom, 16)
        .overlay {
            if enableSuggestionView {
                CircularRadius(color: .gradientOrange)
                    .frame(width: 50, height: 50, alignment: .leading)
                    .offset(x: -51, y: -10)
            }
        }
    }
    
    @ViewBuilder
    func popUpView() -> some View {
        ZStack(alignment: .center) {

            Color.gray.opacity(0.3)
                .ignoresSafeArea()
            
            if enableMeetingView {
                DurationView(statusInfo: $status, completion: { action  in
                    switch action {
                    case .backButton:
                        enableMeetingView(false)
                        disableGeometryEffect = false
                    case .doneButton:
                        updateCurrentStatus(status.selectedStatus)
                        toggleStatusView(enablePopup: false)
                        disableGeometryEffect = true
                    }
                })
                .matchedGeometryEffect(id: disableGeometryEffect ? namespaceID : "", in: namespace)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
            } else {
                TopStatusView()
                    .matchedGeometryEffect(id: namespaceID, in: namespace)
            }
        }
        .animation(.easeOut.speed(1), value: enableMeetingView)
    }
    
    func TopStatusView() -> some View {
        
        VStack(alignment: .center) {
            
            // MARK: - Header
            HeaderView(status: status) {
                toggleStatusView(enablePopup: false)
            }
            .padding(.bottom, 34)
            
            
            // MARK: - Availability view
            AvailabilityView(statusType: .available, isSelected: isStatusSelected(.available)) {
                updateCurrentStatus(.available)
                toggleStatusView(enablePopup: false)
            }
            
            // MARK: - Sub Header
            HStack {
                Text("I'm Not Taking Calls")
                    .font(.custom(AppFont.latoNormal.rawValue, size: 15).weight(.medium))
                    .foregroundColor(.availabilitysubTitle)
                Spacer()
            }
            .padding(.top, 25)
            .padding(.bottom, 15)
            
            
            //MARK: - Status views types
            VStack(spacing: 10) {
                
                ForEach(allAvailabilityStatuses, id: \.id) { statusType in
                    
                    let filteredStatus = (statusType != .available && statusType != .unAvailable)
                    
                    if filteredStatus {
                        let isSelected = (status.currentStatus == .unAvailable && statusType == .custom)
                        ? true
                        : isStatusSelected(statusType)
                        AvailabilityView(statusType: statusType, isSelected: isSelected) {
                            updateSelectedStatus(statusType)
                            enableMeetingView(true)
                        }
                    }
                }
            }
        }
        .padding([.top, .horizontal], 23)
        .padding(.bottom, 39)
        .background(Color.white.animation(.easeInOut))
        .cornerRadius(20)
        .padding(.horizontal, 25)
    }
    
}

// MARK: - Helper functions
extension UserStatusView {
    func isStatusSelected(_ statusType: UserStatusType) -> Bool {
        status.currentStatus == statusType
    }
    
    func updateSelectedStatus(_ statusType: UserStatusType) {
        status.selectedStatus = statusType
    }
    
    func updateCurrentStatus(_ statusType: UserStatusType?) {
        if let statusType {
            status.currentStatus = statusType
        } else {
            debugPrint("Update current status failed - Status is nil (Not updated)!!!!")
        }
    }
    
    func toggleStatusView(enablePopup enable: Bool) {
        withAnimation(.easeInOut) {
            if enable {
                enableMeetingView(false)
                enableSuggestionView(false)
            }
            showStatusSelection = enable
        }
    }
    
    func enableMeetingView(_ enable: Bool) {
        enableMeetingView = enable
    }
    
    func enableSuggestionView(_ enable: Bool) {
        withAnimation {
            enableSuggestionView = enable
        }
    }
}
