import SwiftUI

struct AccessibilitySettingsView: View {
    let brandYellow = Color.brand
    
    @State private var largeText = false
    @State private var highContrast = false
    @State private var reduceMotion = false
    @State private var voiceGuidance = true
    @State private var hapticFeedback = true
    @State private var wheelchairAccessible = false
    @State private var assistanceNeeded = false
    @State private var fontSize: Double = 1.0
    @State private var showPreview = false
    
    var body: some View {
        List {
            // Visual
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Text Size")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 12) {
                        Text("A")
                            .font(.caption)
                        Slider(value: $fontSize, in: 0.8...1.5, step: 0.1)
                            .tint(brandYellow)
                        Text("A")
                            .font(.title2)
                    }
                    
                    Text("Preview: SmartCommute makes commuting easy")
                        .font(.system(size: 14 * fontSize))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                .padding(.vertical, 4)
                
                Toggle(isOn: $highContrast) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("High Contrast", systemImage: "circle.lefthalf.filled")
                        Text("Increase color contrast for better visibility")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
                
                Toggle(isOn: $reduceMotion) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("Reduce Motion", systemImage: "hand.raised.fill")
                        Text("Minimize animations and transitions")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
            } header: {
                Text("Visual")
            }
            
            // Audio & Haptic
            Section {
                Toggle(isOn: $voiceGuidance) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("Voice Guidance", systemImage: "speaker.wave.3.fill")
                        Text("Audio announcements for ride updates")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
                
                Toggle(isOn: $hapticFeedback) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("Haptic Feedback", systemImage: "iphone.radiowaves.left.and.right")
                        Text("Vibration alerts for important events")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
            } header: {
                Text("Audio & Haptic")
            }
            
            // Ride Accessibility
            Section {
                Toggle(isOn: $wheelchairAccessible) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("Wheelchair Accessible", systemImage: "figure.roll")
                        Text("Prefer vehicles with wheelchair access")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
                
                Toggle(isOn: $assistanceNeeded) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("Extra Assistance", systemImage: "person.fill.questionmark")
                        Text("Notify driver that you may need help")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
                
                NavigationLink(destination: EmptyView()) {
                    VStack(alignment: .leading, spacing: 2) {
                        Label("Accessibility Notes", systemImage: "note.text")
                        Text("Add notes for your driver about accessibility needs")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            } header: {
                Text("Ride Accessibility")
            } footer: {
                Text("Drivers will be informed about your accessibility preferences before accepting the ride.")
            }
            
            // Quick presets
            Section {
                Button(action: {
                    withAnimation {
                        largeText = true
                        highContrast = true
                        voiceGuidance = true
                        fontSize = 1.3
                    }
                }) {
                    HStack {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Vision Impaired Preset")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Text("Large text, high contrast, voice guidance")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        wheelchairAccessible = true
                        assistanceNeeded = true
                        hapticFeedback = true
                    }
                }) {
                    HStack {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.green)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Mobility Impaired Preset")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Text("Wheelchair access, extra assistance")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        fontSize = 1.0
                        highContrast = false
                        reduceMotion = false
                        voiceGuidance = true
                        hapticFeedback = true
                        wheelchairAccessible = false
                        assistanceNeeded = false
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.red)
                        Text("Reset to Defaults")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
            } header: {
                Text("Quick Presets")
            }
        }
        .navigationTitle("Accessibility")
        .navigationBarTitleDisplayMode(.large)
    }
}
