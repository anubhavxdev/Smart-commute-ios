import SwiftUI

struct AppLanguage: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let nativeName: String
    let flag: String
    let progress: Int // Translation completion %
}

struct LanguageSelectionView: View {
    let brandYellow = Color.brand
    
    @State private var selectedLanguage = "en"
    @State private var searchText = ""
    @State private var showRestart = false
    
    let languages: [AppLanguage] = [
        AppLanguage(code: "en", name: "English", nativeName: "English", flag: "🇬🇧", progress: 100),
        AppLanguage(code: "hi", name: "Hindi", nativeName: "हिन्दी", flag: "🇮🇳", progress: 100),
        AppLanguage(code: "kn", name: "Kannada", nativeName: "ಕನ್ನಡ", flag: "🇮🇳", progress: 95),
        AppLanguage(code: "ta", name: "Tamil", nativeName: "தமிழ்", flag: "🇮🇳", progress: 92),
        AppLanguage(code: "te", name: "Telugu", nativeName: "తెలుగు", flag: "🇮🇳", progress: 90),
        AppLanguage(code: "ml", name: "Malayalam", nativeName: "മലയാളം", flag: "🇮🇳", progress: 88),
        AppLanguage(code: "mr", name: "Marathi", nativeName: "मराठी", flag: "🇮🇳", progress: 85),
        AppLanguage(code: "bn", name: "Bengali", nativeName: "বাংলা", flag: "🇮🇳", progress: 82),
        AppLanguage(code: "gu", name: "Gujarati", nativeName: "ગુજરાતી", flag: "🇮🇳", progress: 78),
        AppLanguage(code: "pa", name: "Punjabi", nativeName: "ਪੰਜਾਬੀ", flag: "🇮🇳", progress: 75),
        AppLanguage(code: "or", name: "Odia", nativeName: "ଓଡ଼ିଆ", flag: "🇮🇳", progress: 70),
    ]
    
    var filteredLanguages: [AppLanguage] {
        if searchText.isEmpty { return languages }
        return languages.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.nativeName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search language", text: $searchText)
                    .font(.subheadline)
            }
            .padding(12)
            .background(Color.gray.opacity(0.08))
            .cornerRadius(12)
            .padding()
            
            // Current language
            if let current = languages.first(where: { $0.code == selectedLanguage }) {
                HStack(spacing: 14) {
                    Text(current.flag)
                        .font(.title)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Current Language")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(current.name) (\(current.nativeName))")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
                .padding(16)
                .background(brandYellow.opacity(0.08))
                .cornerRadius(14)
                .padding(.horizontal)
            }
            
            // Language list
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredLanguages) { lang in
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                selectedLanguage = lang.code
                                showRestart = true
                            }
                        }) {
                            HStack(spacing: 14) {
                                Text(lang.flag)
                                    .font(.title2)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(lang.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primary)
                                    Text(lang.nativeName)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                if lang.progress < 100 {
                                    Text("\(lang.progress)%")
                                        .font(.caption2)
                                        .foregroundColor(.orange)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 2)
                                        .background(Color.orange.opacity(0.1))
                                        .cornerRadius(4)
                                }
                                
                                if selectedLanguage == lang.code {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(brandYellow)
                                } else {
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                                        .frame(width: 22, height: 22)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                        }
                        
                        Divider().padding(.leading, 60)
                    }
                }
            }
            
            // Note
            HStack(spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
                Text("Some languages are partially translated. Missing text will appear in English.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle("Language")
        .navigationBarTitleDisplayMode(.large)
        .alert("Restart Required", isPresented: $showRestart) {
            Button("Restart Now") { }
            Button("Later", role: .cancel) { }
        } message: {
            Text("The app needs to restart to apply the language change.")
        }
    }
}
