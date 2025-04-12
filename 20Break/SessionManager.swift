import Foundation
import Combine

class SessionManager: ObservableObject {
    @Published var isSessionStarted: Bool = false
    @Published var workTimeRemaining: Int = 20 * 60
}
