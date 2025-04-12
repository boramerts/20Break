import SwiftUI

struct MenuBarIconView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        if sessionManager.isSessionStarted {
            HStack(spacing: 4) {
                Image(systemName: "eyes")
                Text(timeString(from: sessionManager.workTimeRemaining))
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
            }
        } else {
            Image(systemName: "eyes.inverse")
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}
