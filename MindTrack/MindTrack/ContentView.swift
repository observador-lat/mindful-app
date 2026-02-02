//
//  ContentView.swift
//  MindTrack
//
//  Created by Jorge Carrasco on 9/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var characterState = CharacterState()

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: 0) {
                // Solar rail que muestra progreso de la racha
                SolarRailView(
                    topY: 20,
                    bottomY: geometry.size.height - 180,
                    currentY: currentRailPosition(height: geometry.size.height),
                    markerRadius: 6
                )
                .frame(width: 36)

                Spacer()
                    .frame(width: 16)

                ScrollView {
                    VStack(spacing: 24) {
                        // Carta del personaje
                        CharacterCardView(characterState: characterState)

                        // Controles de demostración
                        DemoControlsView(characterState: characterState)
                    }
                }
                .padding(.top, 6)
                .padding(.horizontal, 18)
                .padding(.bottom, 160)
            }
        }
    }

    private func currentRailPosition(height: CGFloat) -> CGFloat {
        let topY: CGFloat = 20
        let bottomY = height - 180
        let totalRange = bottomY - topY

        // La posición se basa en el mood (0-5)
        let moodProgress = CGFloat(characterState.mood.rawValue) / 5.0
        return topY + totalRange * (1 - moodProgress)
    }
}

// MARK: - Demo Controls (para testing)
struct DemoControlsView: View {
    let characterState: CharacterState

    var body: some View {
        VStack(spacing: 16) {
            Text("Controles de prueba")
                .font(.headline)
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Button(action: {
                    characterState.completePomodoro()
                }) {
                    Label("Completar Pomodoro", systemImage: "checkmark.circle.fill")
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.green.opacity(0.2))
                        .foregroundStyle(.green)
                        .clipShape(Capsule())
                }

                Button(action: {
                    characterState.breakStreak()
                }) {
                    Label("Romper racha", systemImage: "xmark.circle.fill")
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.red.opacity(0.2))
                        .foregroundStyle(.red)
                        .clipShape(Capsule())
                }
            }

            Button(action: {
                characterState.reset()
            }) {
                Label("Reiniciar", systemImage: "arrow.counterclockwise")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    ContentView()
}
