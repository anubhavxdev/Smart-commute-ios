import SwiftUI

enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}

struct ThemeSettingsView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    @State private var selectedTheme: AppTheme = .system
    @State private var useAutoSwitch = true
    @State private var sunsetTime = "6:30 PM"
    @State private var sunriseTime = "6:00 AM"
    @State private var accentColor = "Yellow"
    
    let accentColors: [(String, Color)] = [
        ("Yellow", Color(red: 0.98, green: 0.79, blue: 0.21)),
        ("Blue", .blue),
        ("Green", .green),
        ("Purple", .purple),
        ("Orange", .orange),
        ("Pink", .pink),
    ]
    
    var body: some View {
        List {
            // Theme selection
            Section {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) { selectedTheme = theme }
                    }) {
                        HStack(spacing: 16) {
                            // Theme preview
                            ThemePreviewCard(theme: theme, brandYellow: brandYellow)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(theme.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                
                                Text(themeDescription(theme))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            if selectedTheme == theme {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(brandYellow)
                            }
                        }
                    }
                }
            } header: {
                Text("Appearance")
            }
            
            // Auto switch
            Section {
                Toggle(isOn: $useAutoSwitch) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Auto Dark Mode")
                            .font(.subheadline)
                        Text("Switch based on sunset/sunrise")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .tint(brandYellow)
                
                if useAutoSwitch {
                    HStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(.orange)
                        Text("Light Mode at")
                        Spacer()
                        Text(sunriseTime)
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)
                    
                    HStack {
                        Image(systemName: "sunset.fill")
                            .foregroundColor(.purple)
                        Text("Dark Mode at")
                        Spacer()
                        Text(sunsetTime)
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)
                }
            } header: {
                Text("Schedule")
            }
            
            // Accent color
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Choose your accent color")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 12) {
                        ForEach(accentColors, id: \.0) { name, color in
                            Button(action: {
                                withAnimation(.spring(response: 0.3)) { accentColor = name }
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(color)
                                        .frame(width: 44, height: 44)
                                    
                                    if accentColor == name {
                                        Image(systemName: "checkmark")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 4)
            } header: {
                Text("Accent Color")
            }
            
            // Map theme
            Section {
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.green)
                        Text("Map Style")
                        Spacer()
                        Text("Standard")
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)
                }
                
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Image(systemName: "photo.fill")
                            .foregroundColor(.blue)
                        Text("App Icon")
                        Spacer()
                        Text("Default")
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)
                }
            } header: {
                Text("Customization")
            }
            
            // Preview section
            Section {
                VStack(spacing: 12) {
                    Text("Theme Preview")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    // Mock card preview
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(accentColors.first(where: { $0.0 == accentColor })?.1.opacity(0.15) ?? brandYellow.opacity(0.15))
                                .frame(width: 40, height: 40)
                            Image(systemName: "car.fill")
                                .foregroundColor(accentColors.first(where: { $0.0 == accentColor })?.1 ?? brandYellow)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Sample Ride Card")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text("Koramangala → HSR Layout")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("₹75")
                            .font(.headline)
                            .foregroundColor(accentColors.first(where: { $0.0 == accentColor })?.1 ?? brandYellow)
                    }
                    .padding(14)
                    .background(Color.gray.opacity(0.06))
                    .cornerRadius(12)
                }
            } header: {
                Text("Preview")
            }
        }
        .navigationTitle("Theme")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func themeDescription(_ theme: AppTheme) -> String {
        switch theme {
        case .system: return "Match your device settings"
        case .light: return "Always use light appearance"
        case .dark: return "Always use dark appearance"
        }
    }
}

struct ThemePreviewCard: View {
    let theme: AppTheme
    let brandYellow: Color
    
    var bgColor: Color {
        switch theme {
        case .system: return Color.gray.opacity(0.1)
        case .light: return .white
        case .dark: return Color.black.opacity(0.8)
        }
    }
    
    var fgColor: Color {
        switch theme {
        case .system: return .black
        case .light: return .black
        case .dark: return .white
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(bgColor)
                .frame(width: 48, height: 48)
            
            if theme == .system {
                HStack(spacing: 0) {
                    Rectangle().fill(.white).frame(width: 24)
                    Rectangle().fill(.black.opacity(0.8)).frame(width: 24)
                }
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Image(systemName: theme == .dark ? "moon.fill" : (theme == .light ? "sun.max.fill" : "circle.lefthalf.filled"))
                .font(.caption)
                .foregroundColor(theme == .dark ? brandYellow : (theme == .system ? .gray : .orange))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
