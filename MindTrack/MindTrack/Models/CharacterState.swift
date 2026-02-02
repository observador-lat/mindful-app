import Foundation
import SwiftUI

// MARK: - Mood (Estado de ánimo basado en rachas)
enum Mood: Int, CaseIterable, Codable {
    case sad = 0        // triste - sin rachas
    case tired = 1      // cansado - 1-2 pomodoros
    case bored = 2      // aburrido - 3-4 pomodoros
    case happy = 3      // contento - 5-7 pomodoros
    case focused = 4    // enfocado - 8-11 pomodoros
    case buddha = 5     // modo buda - 12+ pomodoros

    var name: String {
        switch self {
        case .sad: return "Triste"
        case .tired: return "Cansado"
        case .bored: return "Aburrido"
        case .happy: return "Contento"
        case .focused: return "Enfocado"
        case .buddha: return "Modo Buda"
        }
    }

    var auraIntensity: Double {
        switch self {
        case .sad: return 0.0
        case .tired: return 0.1
        case .bored: return 0.2
        case .happy: return 0.4
        case .focused: return 0.7
        case .buddha: return 1.0
        }
    }

    var auraColor: Color {
        switch self {
        case .sad: return .clear
        case .tired: return .gray.opacity(0.3)
        case .bored: return .blue.opacity(0.3)
        case .happy: return .yellow.opacity(0.4)
        case .focused: return .orange.opacity(0.5)
        case .buddha: return .purple.opacity(0.6)
        }
    }

    static func fromStreak(_ streak: Int) -> Mood {
        switch streak {
        case 0: return .sad
        case 1...2: return .tired
        case 3...4: return .bored
        case 5...7: return .happy
        case 8...11: return .focused
        default: return .buddha
        }
    }
}

// MARK: - Evolution (Evolución del personaje)
enum Evolution: Int, CaseIterable, Codable {
    case baby = 0       // Gatito bebé
    case kitten = 1     // Gatito joven
    case cat = 2        // Gato adulto
    case master = 3     // Gato maestro
    case enlightened = 4 // Gato iluminado

    var name: String {
        switch self {
        case .baby: return "Gatito Bebé"
        case .kitten: return "Gatito Joven"
        case .cat: return "Gato Andino"
        case .master: return "Gato Maestro"
        case .enlightened: return "Gato Iluminado"
        }
    }

    var scale: CGFloat {
        switch self {
        case .baby: return 0.6
        case .kitten: return 0.75
        case .cat: return 0.9
        case .master: return 1.0
        case .enlightened: return 1.15
        }
    }

    var requiredTotalPomodoros: Int {
        switch self {
        case .baby: return 0
        case .kitten: return 25
        case .cat: return 75
        case .master: return 150
        case .enlightened: return 300
        }
    }

    static func fromTotalPomodoros(_ total: Int) -> Evolution {
        if total >= 300 { return .enlightened }
        if total >= 150 { return .master }
        if total >= 75 { return .cat }
        if total >= 25 { return .kitten }
        return .baby
    }
}

// MARK: - Character State
@Observable
class CharacterState {
    var currentStreak: Int = 0
    var totalPomodoros: Int = 0
    var characterName: String = "Michi"

    var mood: Mood {
        Mood.fromStreak(currentStreak)
    }

    var evolution: Evolution {
        Evolution.fromTotalPomodoros(totalPomodoros)
    }

    func completePomodoro() {
        currentStreak += 1
        totalPomodoros += 1
    }

    func breakStreak() {
        currentStreak = 0
    }

    func reset() {
        currentStreak = 0
        totalPomodoros = 0
    }
}
