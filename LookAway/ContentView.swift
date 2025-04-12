import SwiftUI
import AVFoundation
import ObjectiveC.runtime

struct ContentView: View {
    @Environment(\.openWindow) var openWindow
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var breakTimeRemaining: Int = UserDefaults.standard.integer(forKey: "breakDuration") != 0 ? UserDefaults.standard.integer(forKey: "breakDuration") : 20
    @State var timer: Timer? = nil
    
    var body: some View {
        Group {
            if sessionManager.isSessionStarted {
                sessionView
            } else {
                homeView
            }
        }
        // Listen for when the break ends and reset the session timer
        .onReceive(NotificationCenter.default.publisher(for: .breakEnded)) { _ in
            endBreak()
        }
    }
    
    var sessionView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "eyes")
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                Text("Session started. Keep working.")
                    .font(.title2)
                    .lineLimit(2)
                Spacer()
                Button(action: {
                    openWindow(id: "settings")
                }) {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }
                .buttonStyle(.borderless)
            }
            .padding(.bottom)
            HStack {
                Text("Remaining time: \(timeString(from: sessionManager.workTimeRemaining))")
                Spacer()
                Button {
                    stopSession()
                } label: {
                    Text("End Session")
                }
                Button {
                    quitSession()
                } label: {
                    Text("Quit")
                }
            }
        }
        .frame(width: 320)
        .padding()
        .onAppear {
            AudioServicesPlaySystemSound(1026)
            startWorkTimer()
        }
    }
    
    var homeView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "eyes")
                    .imageScale(.large)
                    .foregroundStyle(.primary)
                Text("Take care of your eyes")
                    .font(.title2)
                    .lineLimit(1)
                Spacer()
                Button(action: {
                    openWindow(id: "settings")
                }) {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }
                .buttonStyle(.borderless)
            }
            .padding(.bottom)
            
            HStack {
                Button {
                    startSession()
                } label: {
                    Text("Start Session")
                }
                Spacer()
                Button {
                    quitSession()
                } label: {
                    Text("Quit")
                }
            }
        }
        .frame(width: 320)
        .padding()
    }
    
    func startSession() {
        sessionManager.isSessionStarted = true
        sessionManager.workTimeRemaining = UserDefaults.standard.integer(forKey: "workDuration") != 0 ? UserDefaults.standard.integer(forKey: "workDuration") : 20 * 60
        startWorkTimer()
    }
    
    func stopSession() {
        timer?.invalidate()
        timer = nil
        sessionManager.isSessionStarted = false
    }
    
    func quitSession() {
        timer?.invalidate()
        timer = nil
        sessionManager.isSessionStarted = false
    }
    
    func startWorkTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if sessionManager.workTimeRemaining > 0 {
                sessionManager.workTimeRemaining -= 1
            } else {
                timer?.invalidate()
                // When session time is up, open break window
                breakTimeRemaining = UserDefaults.standard.integer(forKey: "breakDuration") != 0 ? UserDefaults.standard.integer(forKey: "breakDuration") : 20
                openWindow(id: "break")
            }
        }
    }
    
    // Called when break ends; reset the session timer and start a new session.
    func endBreak() {
        timer?.invalidate()
        timer = nil
        // Restart the session by setting a new work time and starting the timer again.
        startSession()
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02dm %02ds", minutes, secs)
    }
}

#Preview {
    ContentView()
}
