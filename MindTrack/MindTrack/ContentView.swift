//
//  ContentView.swift
//  MindTrack
//
//  Created by Jorge Carrasco on 9/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            SolarRailView()
                .frame(width: 36)

            Spacer()
                .frame(width: 16)

            ScrollView {
                VStack(spacing: 16) {
                    EmptyView()
                }
            }
            .padding(.top, 6)
            .padding(.horizontal, 18)
            .padding(.bottom, 160)
        }
    }
}

struct SolarRailView: View {
    var body: some View {
        Color.clear
    }
}

#Preview {
    ContentView()
}
