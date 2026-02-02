import SwiftUI

struct PixelKittyView: View {
    let mood: Mood
    let evolution: Evolution
    let pixelSize: CGFloat

    init(mood: Mood, evolution: Evolution, pixelSize: CGFloat = 8) {
        self.mood = mood
        self.evolution = evolution
        self.pixelSize = pixelSize
    }

    // Colores del gatito andino
    private let furColor = Color(red: 0.6, green: 0.5, blue: 0.4)      // Marrón grisáceo
    private let furDark = Color(red: 0.45, green: 0.35, blue: 0.3)     // Marrón oscuro
    private let furLight = Color(red: 0.75, green: 0.65, blue: 0.55)   // Marrón claro
    private let eyeWhite = Color.white
    private let eyeBlack = Color.black
    private let noseColor = Color(red: 0.85, green: 0.6, blue: 0.6)    // Rosa
    private let innerEar = Color(red: 0.9, green: 0.75, blue: 0.75)    // Rosa claro

    var body: some View {
        let scale = evolution.scale
        let scaledPixel = pixelSize * scale

        ZStack {
            // Aura de meditación
            if mood.auraIntensity > 0 {
                AuraView(intensity: mood.auraIntensity, color: mood.auraColor)
                    .frame(
                        width: 22 * scaledPixel + 40 * mood.auraIntensity,
                        height: 24 * scaledPixel + 40 * mood.auraIntensity
                    )
            }

            // Gatito pixel art
            Canvas { context, size in
                let offsetX = (size.width - 18 * scaledPixel) / 2
                let offsetY = (size.height - 20 * scaledPixel) / 2

                func drawPixel(x: Int, y: Int, color: Color) {
                    let rect = CGRect(
                        x: offsetX + CGFloat(x) * scaledPixel,
                        y: offsetY + CGFloat(y) * scaledPixel,
                        width: scaledPixel,
                        height: scaledPixel
                    )
                    context.fill(Path(rect), with: .color(color))
                }

                // Dibujar el cuerpo base
                drawBody(draw: drawPixel)

                // Dibujar las orejas
                drawEars(draw: drawPixel)

                // Dibujar la cara según el mood
                drawFace(draw: drawPixel, mood: mood)

                // Detalles especiales por evolución
                if evolution.rawValue >= Evolution.master.rawValue {
                    drawMasterDetails(draw: drawPixel)
                }

                if evolution == .enlightened {
                    drawEnlightenedDetails(draw: drawPixel, context: context, size: size, scaledPixel: scaledPixel, offsetX: offsetX, offsetY: offsetY)
                }
            }
            .frame(width: 22 * scaledPixel, height: 24 * scaledPixel)
        }
    }

    // MARK: - Drawing Functions

    private func drawBody(draw: (Int, Int, Color) -> Void) {
        // Cuerpo principal (matriz 18x20 aproximadamente)
        // Filas 8-17: Cuerpo
        for x in 4...13 {
            for y in 8...16 {
                draw(x, y, furColor)
            }
        }

        // Pecho más claro
        for x in 6...11 {
            for y in 10...14 {
                draw(x, y, furLight)
            }
        }

        // Patitas delanteras
        for y in 15...18 {
            draw(4, y, furColor)
            draw(5, y, furColor)
            draw(12, y, furColor)
            draw(13, y, furColor)
        }

        // Patitas - puntas más oscuras
        draw(4, 18, furDark)
        draw(5, 18, furDark)
        draw(12, 18, furDark)
        draw(13, 18, furDark)

        // Cabeza (más grande que el cuerpo)
        for x in 3...14 {
            for y in 2...9 {
                draw(x, y, furColor)
            }
        }

        // Redondeado de la cabeza
        draw(2, 4, furColor)
        draw(2, 5, furColor)
        draw(2, 6, furColor)
        draw(15, 4, furColor)
        draw(15, 5, furColor)
        draw(15, 6, furColor)

        // Cola (lado derecho, curvada hacia arriba)
        for y in 12...15 {
            draw(14, y, furColor)
        }
        draw(15, 11, furColor)
        draw(15, 12, furColor)
        draw(16, 10, furColor)
        draw(16, 11, furDark)  // Punta de la cola
    }

    private func drawEars(draw: (Int, Int, Color) -> Void) {
        // Oreja izquierda (triangular, típica de gato andino - más pequeña)
        draw(3, 0, furColor)
        draw(4, 0, furColor)
        draw(2, 1, furColor)
        draw(3, 1, innerEar)
        draw(4, 1, furColor)
        draw(5, 1, furColor)

        // Oreja derecha
        draw(13, 0, furColor)
        draw(14, 0, furColor)
        draw(12, 1, furColor)
        draw(13, 1, innerEar)
        draw(14, 1, furColor)
        draw(15, 1, furColor)
    }

    private func drawFace(draw: (Int, Int, Color) -> Void, mood: Mood) {
        // Nariz
        draw(8, 6, noseColor)
        draw(9, 6, noseColor)

        // Ojos según el mood
        switch mood {
        case .sad:
            drawSadEyes(draw: draw)
        case .tired:
            drawTiredEyes(draw: draw)
        case .bored:
            drawBoredEyes(draw: draw)
        case .happy:
            drawHappyEyes(draw: draw)
        case .focused:
            drawFocusedEyes(draw: draw)
        case .buddha:
            drawBuddhaEyes(draw: draw)
        }

        // Boca según el mood
        drawMouth(draw: draw, mood: mood)

        // Bigotes
        draw(2, 5, furDark)
        draw(1, 6, furDark)
        draw(2, 7, furDark)

        draw(15, 5, furDark)
        draw(16, 6, furDark)
        draw(15, 7, furDark)

        // Marcas faciales del gato andino (líneas características)
        draw(4, 3, furDark)
        draw(13, 3, furDark)
    }

    private func drawSadEyes(draw: (Int, Int, Color) -> Void) {
        // Ojos caídos, tristes
        draw(5, 4, eyeWhite)
        draw(6, 4, eyeWhite)
        draw(5, 5, eyeBlack)
        draw(6, 5, eyeWhite)

        draw(11, 4, eyeWhite)
        draw(12, 4, eyeWhite)
        draw(11, 5, eyeWhite)
        draw(12, 5, eyeBlack)

        // Cejas caídas
        draw(4, 3, furDark)
        draw(13, 3, furDark)
    }

    private func drawTiredEyes(draw: (Int, Int, Color) -> Void) {
        // Ojos entrecerrados
        draw(5, 5, eyeBlack)
        draw(6, 5, eyeBlack)
        draw(11, 5, eyeBlack)
        draw(12, 5, eyeBlack)
    }

    private func drawBoredEyes(draw: (Int, Int, Color) -> Void) {
        // Ojos mirando al lado
        draw(5, 4, eyeWhite)
        draw(6, 4, eyeWhite)
        draw(5, 5, eyeWhite)
        draw(6, 5, eyeBlack)

        draw(11, 4, eyeWhite)
        draw(12, 4, eyeWhite)
        draw(11, 5, eyeWhite)
        draw(12, 5, eyeBlack)
    }

    private func drawHappyEyes(draw: (Int, Int, Color) -> Void) {
        // Ojos alegres (arcos)
        draw(5, 4, eyeBlack)
        draw(6, 4, eyeBlack)
        draw(5, 5, eyeWhite)
        draw(6, 5, eyeWhite)

        draw(11, 4, eyeBlack)
        draw(12, 4, eyeBlack)
        draw(11, 5, eyeWhite)
        draw(12, 5, eyeWhite)
    }

    private func drawFocusedEyes(draw: (Int, Int, Color) -> Void) {
        // Ojos determinados, brillantes
        draw(5, 4, eyeWhite)
        draw(6, 4, eyeWhite)
        draw(5, 5, eyeBlack)
        draw(6, 5, eyeBlack)

        draw(11, 4, eyeWhite)
        draw(12, 4, eyeWhite)
        draw(11, 5, eyeBlack)
        draw(12, 5, eyeBlack)

        // Brillo en los ojos
        draw(5, 4, Color.white.opacity(0.8))
        draw(11, 4, Color.white.opacity(0.8))
    }

    private func drawBuddhaEyes(draw: (Int, Int, Color) -> Void) {
        // Ojos cerrados en meditación (líneas horizontales)
        draw(5, 4, eyeBlack)
        draw(6, 4, eyeBlack)
        draw(7, 4, eyeBlack)

        draw(10, 4, eyeBlack)
        draw(11, 4, eyeBlack)
        draw(12, 4, eyeBlack)
    }

    private func drawMouth(draw: (Int, Int, Color) -> Void, mood: Mood) {
        let mouthColor = Color(red: 0.3, green: 0.2, blue: 0.2)

        switch mood {
        case .sad:
            // Boca triste (curva hacia abajo)
            draw(7, 8, mouthColor)
            draw(10, 8, mouthColor)
            draw(8, 9, mouthColor)
            draw(9, 9, mouthColor)
        case .tired:
            // Boca neutra
            draw(7, 8, mouthColor)
            draw(8, 8, mouthColor)
            draw(9, 8, mouthColor)
            draw(10, 8, mouthColor)
        case .bored:
            // Boca ligeramente abierta
            draw(8, 7, mouthColor)
            draw(9, 7, mouthColor)
            draw(8, 8, mouthColor)
            draw(9, 8, mouthColor)
        case .happy:
            // Sonrisa
            draw(7, 7, mouthColor)
            draw(10, 7, mouthColor)
            draw(8, 8, mouthColor)
            draw(9, 8, mouthColor)
        case .focused:
            // Boca determinada (línea recta)
            draw(7, 7, mouthColor)
            draw(8, 7, mouthColor)
            draw(9, 7, mouthColor)
            draw(10, 7, mouthColor)
        case .buddha:
            // Sonrisa serena
            draw(6, 7, mouthColor)
            draw(11, 7, mouthColor)
            draw(7, 8, mouthColor)
            draw(8, 8, mouthColor)
            draw(9, 8, mouthColor)
            draw(10, 8, mouthColor)
        }
    }

    private func drawMasterDetails(draw: (Int, Int, Color) -> Void) {
        // Collar de maestro
        let goldColor = Color(red: 0.85, green: 0.7, blue: 0.3)
        for x in 5...12 {
            draw(x, 10, goldColor)
        }
    }

    private func drawEnlightenedDetails(
        draw: (Int, Int, Color) -> Void,
        context: GraphicsContext,
        size: CGSize,
        scaledPixel: CGFloat,
        offsetX: CGFloat,
        offsetY: CGFloat
    ) {
        // Tercer ojo
        let thirdEyeColor = Color.purple
        draw(8, 2, thirdEyeColor)
        draw(9, 2, thirdEyeColor)

        // Halo dorado
        let haloColor = Color(red: 1.0, green: 0.85, blue: 0.3).opacity(0.6)
        let centerX = offsetX + 9 * scaledPixel
        let centerY = offsetY - 2 * scaledPixel

        let haloPath = Path(ellipseIn: CGRect(
            x: centerX - 4 * scaledPixel,
            y: centerY - 1 * scaledPixel,
            width: 8 * scaledPixel,
            height: 3 * scaledPixel
        ))
        context.stroke(haloPath, with: .color(haloColor), lineWidth: 2)
    }
}

// MARK: - Aura View
struct AuraView: View {
    let intensity: Double
    let color: Color

    @State private var animationPhase: Double = 0

    var body: some View {
        ZStack {
            // Múltiples capas de aura
            ForEach(0..<3) { layer in
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                color.opacity(0.3 * intensity),
                                color.opacity(0.1 * intensity),
                                .clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: 100
                        )
                    )
                    .scaleEffect(1.0 + Double(layer) * 0.2 + animationPhase * 0.1)
                    .opacity(0.6 - Double(layer) * 0.15)
            }

            // Partículas de energía para niveles altos
            if intensity > 0.5 {
                ForEach(0..<Int(intensity * 8), id: \.self) { index in
                    Circle()
                        .fill(color)
                        .frame(width: 4, height: 4)
                        .offset(
                            x: cos(Double(index) * .pi / 4 + animationPhase) * 40 * intensity,
                            y: sin(Double(index) * .pi / 4 + animationPhase) * 40 * intensity
                        )
                        .opacity(0.6)
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                animationPhase = .pi * 2
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 40) {
        HStack(spacing: 30) {
            VStack {
                PixelKittyView(mood: .sad, evolution: .baby)
                Text("Triste - Bebé")
                    .font(.caption)
            }
            VStack {
                PixelKittyView(mood: .happy, evolution: .kitten)
                Text("Contento - Joven")
                    .font(.caption)
            }
            VStack {
                PixelKittyView(mood: .buddha, evolution: .enlightened)
                Text("Buddha - Iluminado")
                    .font(.caption)
            }
        }
    }
    .padding()
}
