import SwiftUI

struct CharacterCardView: View {
    let characterState: CharacterState

    var body: some View {
        VStack(spacing: 16) {
            // Nombre y evolución
            VStack(spacing: 4) {
                Text(characterState.characterName)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(characterState.evolution.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Personaje pixel art
            PixelKittyView(
                mood: characterState.mood,
                evolution: characterState.evolution,
                pixelSize: 6
            )
            .frame(height: 180)

            // Estado de ánimo
            HStack {
                Image(systemName: moodIcon)
                    .foregroundStyle(characterState.mood.auraColor.opacity(1.0))
                Text(characterState.mood.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(characterState.mood.auraColor.opacity(0.2))
            .clipShape(Capsule())

            // Stats
            HStack(spacing: 24) {
                StatView(
                    icon: "flame.fill",
                    value: "\(characterState.currentStreak)",
                    label: "Racha"
                )

                StatView(
                    icon: "clock.fill",
                    value: "\(characterState.totalPomodoros)",
                    label: "Total"
                )

                StatView(
                    icon: "arrow.up.circle.fill",
                    value: "\(pomodorosToNextEvolution)",
                    label: "Siguiente"
                )
            }

            // Barra de progreso hacia siguiente evolución
            if characterState.evolution != .enlightened {
                EvolutionProgressBar(
                    current: characterState.totalPomodoros,
                    evolution: characterState.evolution
                )
            } else {
                Text("Iluminación alcanzada")
                    .font(.caption)
                    .foregroundStyle(.purple)
                    .fontWeight(.medium)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .shadow(color: characterState.mood.auraColor.opacity(0.3), radius: 10)
        )
    }

    private var moodIcon: String {
        switch characterState.mood {
        case .sad: return "cloud.rain.fill"
        case .tired: return "moon.zzz.fill"
        case .bored: return "face.smiling"
        case .happy: return "sun.max.fill"
        case .focused: return "eye.fill"
        case .buddha: return "sparkles"
        }
    }

    private var pomodorosToNextEvolution: Int {
        let currentTotal = characterState.totalPomodoros
        let allEvolutions = Evolution.allCases

        guard let currentIndex = allEvolutions.firstIndex(of: characterState.evolution),
              currentIndex < allEvolutions.count - 1 else {
            return 0
        }

        let nextEvolution = allEvolutions[currentIndex + 1]
        return max(0, nextEvolution.requiredTotalPomodoros - currentTotal)
    }
}

// MARK: - Stat View
struct StatView: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.orange)

            Text(value)
                .font(.headline)
                .fontWeight(.bold)

            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Evolution Progress Bar
struct EvolutionProgressBar: View {
    let current: Int
    let evolution: Evolution

    private var progress: Double {
        let allEvolutions = Evolution.allCases
        guard let currentIndex = allEvolutions.firstIndex(of: evolution),
              currentIndex < allEvolutions.count - 1 else {
            return 1.0
        }

        let nextEvolution = allEvolutions[currentIndex + 1]
        let currentRequired = evolution.requiredTotalPomodoros
        let nextRequired = nextEvolution.requiredTotalPomodoros
        let range = nextRequired - currentRequired

        guard range > 0 else { return 1.0 }

        return Double(current - currentRequired) / Double(range)
    }

    private var nextEvolutionName: String {
        let allEvolutions = Evolution.allCases
        guard let currentIndex = allEvolutions.firstIndex(of: evolution),
              currentIndex < allEvolutions.count - 1 else {
            return ""
        }
        return allEvolutions[currentIndex + 1].name
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Progreso a \(nextEvolutionName)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.gray.opacity(0.2))

                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [.orange, .yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress)
                }
            }
            .frame(height: 8)
        }
    }
}

// MARK: - Preview
#Preview {
    let state = CharacterState()
    state.currentStreak = 5
    state.totalPomodoros = 30

    return CharacterCardView(characterState: state)
        .padding()
}
