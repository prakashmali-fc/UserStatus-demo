//
//  TabBarView.swift
//  AvailabilityStatusToggler
//
//  Created by Vikas on 13/06/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State var enableOverlay: Bool = false
    
    var body: some View {
            
        ZStack(alignment: .bottom) {
            TabView {
                ListView(showStatusSelection: $enableOverlay)
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                Text("Empty View")
                    .tabItem {
                        Label("List", systemImage: "clock")
                    }
            }
            TabbarOverlay(enable: $enableOverlay)
            //Overlay is supported from iOS 15 & zstack is not needed for overlay
//            .overlay(alignment: .bottom) {
//                TabbarOverlay(showPopUp: $showPopUp)
//            }
        }
    }
}

struct TabbarOverlay: View {
    @Binding var enable: Bool
    
    var body: some View {
        if enable {
            Color.gray.opacity(0.3)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .ignoresSafeArea(.all)
                .frame(height: 50)
        }
    }
}


struct ListView: View {

    @Binding var showStatusSelection: Bool
    @State var status = UserStatus()

    var body: some View {
        ZStack(alignment: .bottom){
            List {
                ForEach(0..<25) { index in
                    Text("Index value :\(index)")
                        .onTapGesture {
                            print(index, "tapped")
                        }
                }
            }
            .listStyle(.plain)
            .onChange(of: status) { newValue in
                debugPrint("newValue", newValue)
            }
            // Bottom Status Toggle View1
            UserStatusView(status: $status)
        }
    }
}
