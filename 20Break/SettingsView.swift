import SwiftUI

struct SettingsView: View {
    @State private var workDuration: Int = {
        let stored = UserDefaults.standard.integer(forKey: "workDuration")
        return stored == 0 ? 20 : stored / 60
    }()

    @State private var breakDuration: Int = {
        let stored = UserDefaults.standard.integer(forKey: "breakDuration")
        return stored == 0 ? 20 : stored
    }()
    
    @State private var saveButtonText = "Save Settings"
    @State private var resetButtonText = "Reset Defaults"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 10)
            Text("Welcome to 20Break, your simple utility to reduce eye strain. This app follows the 20-20-20 rule (every 20 minutes, take a 20-second break and look at something 20 feet (6 meters) away). Adjust your session and break durations below to suit your needs.")
                .font(.callout)
                .lineLimit(5)
                .frame(height: 75)
            
            Divider()
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Durations")
                    .font(.title2)
                    .bold()
                
                HStack {
                    Text("Session Duration (minutes):")
                    Spacer()
                    Stepper(value: $workDuration, in: 1...120, step: 1) {
                        Text("\(workDuration) min")
                    }
                    .onChange(of: workDuration) { old, new in
                        saveButtonText = "Save Settings"
                        if new != 20 {
                            resetButtonText = "Reset Defaults"
                        }
                    }
                }
                
                HStack {
                    Text("Break Duration (seconds):")
                    Spacer()
                    Stepper(value: $breakDuration, in: 5...300, step: 5) {
                        Text("\(breakDuration) sec")
                    }
                    .onChange(of: breakDuration) { old, new in
                        saveButtonText = "Save Settings"
                        if new != 20 {
                            resetButtonText = "Reset Defaults"
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            
            HStack {
                Text("20Break | By Bora Mert 2025")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Button {
                    // Reset the state variables to defaults
                    workDuration = 20
                    breakDuration = 20
                    
                    resetButtonText = "Complete"
                    
                    // Update UserDefaults with default values
                    UserDefaults.standard.set(workDuration * 60, forKey: "workDuration")
                    UserDefaults.standard.set(breakDuration, forKey: "breakDuration")
                } label: {
                    Text(resetButtonText)
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(resetButtonText == "Complete" ? .gray : .secondary)
                
                Button {
                    saveSettings()
                } label: {
                    Text(saveButtonText)
                        .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(saveButtonText == "Saved" ? .gray : .blue)
            }
        }
        .padding()
        .frame(width: 400, height: 350)
    }
    
    func saveSettings() {
        UserDefaults.standard.set(workDuration * 60, forKey: "workDuration")
        UserDefaults.standard.set(breakDuration, forKey: "breakDuration")
        saveButtonText = "Saved"
    }
}

#Preview {
    SettingsView()
}
