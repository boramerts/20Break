import SwiftUI
import AVFoundation

struct BreakView: View {
    @State private var initialBreakDuration: Int = {
        let stored = UserDefaults.standard.integer(forKey: "breakDuration")
        return stored == 0 ? 20 : stored
    }()
    
    @State private var breakTimeRemaining: Int = {
        let stored = UserDefaults.standard.integer(forKey: "breakDuration")
        return stored == 0 ? 20 : stored
    }()
    
    @State private var timer: Timer? = nil
    @Environment(\.dismiss) private var dismiss
    
    // Calculate progress for the circular timer (from 0.0 to 1.0)
    var progress: Double {
        Double(breakTimeRemaining) / Double(initialBreakDuration)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Time to take a break!")
                .font(.largeTitle)
                .bold()
            
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 15)
                    .frame(width: 200, height: 200)
                
                // Progress circle
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut, value: progress)
                
                // Countdown text
                Text("\(breakTimeRemaining)")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            Text("Please look away from your screen.")
                .font(.title3)
            
            HStack {
                Button(action: {
                    endBreak()
                }) {
                    Text("Skip Break")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    quitBreak()
                }) {
                    Text("Quit")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .frame(width: 400)
        .background(Color(NSColor.windowBackgroundColor))
        .shadow(radius: 10)
        .interactiveDismissDisabled(true)
        .onAppear {
            NSApp.activate(ignoringOtherApps: true) // Bring window to front
            startBreakTimer()
        }
    }
    
    func startBreakTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if breakTimeRemaining > 0 {
                withAnimation(.easeInOut(duration: 1.0)) {
                    breakTimeRemaining -= 1
                }
            } else {
                timer?.invalidate()
                // Post notification and dismiss when break ends naturally
                NotificationCenter.default.post(name: .breakEnded, object: nil)
                dismiss()
            }
        }
    }
    
    func endBreak() {
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.post(name: .breakEnded, object: nil)
        dismiss()
    }
    
    func quitBreak() {
        timer?.invalidate()
        timer = nil
        NotificationCenter.default.post(name: .breakEnded, object: nil)
        dismiss()
    }
}

struct BreakView_Previews: PreviewProvider {
    static var previews: some View {
        BreakView()
    }
}
