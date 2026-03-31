import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var notificationsEnabled = true
    @State private var locationEnabled = true
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        List {
            // Profile Section
            Section {
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(authViewModel.email.components(separatedBy: "@").first?.capitalized ?? "User")
                            .font(.headline)
                        Text(authViewModel.email)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("+91 98765 43210")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Edit")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(brandYellow)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
                .padding(.vertical, 8)
            }
            
            // Preferences
            Section(header: Text("Preferences")) {
                Toggle(isOn: $notificationsEnabled) {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tint(brandYellow)
                
                Toggle(isOn: $locationEnabled) {
                    Label("Location Services", systemImage: "location.fill")
                }
                .tint(brandYellow)
            }
            
            // Saved Places
            Section(header: Text("Saved Places")) {
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(brandYellow)
                        .frame(width: 30)
                    VStack(alignment: .leading) {
                        Text("Home")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("HSR Layout, Sector 2")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack {
                    Image(systemName: "briefcase.fill")
                        .foregroundColor(brandYellow)
                        .frame(width: 30)
                    VStack(alignment: .leading) {
                        Text("Office")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text("Koramangala 5th Block")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text("Add New Place")
                            .font(.subheadline)
                    }
                }
            }
            
            // General
            Section(header: Text("General")) {
                NavigationLink(destination: EmptyView()) {
                    Label("Privacy Policy", systemImage: "lock.shield.fill")
                }
                NavigationLink(destination: EmptyView()) {
                    Label("Terms of Service", systemImage: "doc.text.fill")
                }
                NavigationLink(destination: EmptyView()) {
                    Label("Help & Support", systemImage: "questionmark.circle.fill")
                }
            }
            
            // Danger Zone
            Section {
                Button(action: {
                    authViewModel.isLoggedIn = false
                }) {
                    HStack {
                        Spacer()
                        Text("Logout")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
            
            // Footer
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text("SmartCommute")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("Version 1.0.0")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}
