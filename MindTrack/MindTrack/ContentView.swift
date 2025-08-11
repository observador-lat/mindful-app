//
//  ContentView.swift
//  MindTrack
//
//  Created by Jorge Carrasco on 9/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hello, world!")
                }
                .padding()
            }
            .padding(.bottom, 160)

            BottomBar()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
