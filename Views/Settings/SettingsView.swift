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
                NavigationLink(destination: ProfileView().environmentObject(authViewModel)) {
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
                NavigationLink(destination: SavedAddressesView()) {
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
                }
                
                NavigationLink(destination: SavedAddressesView()) {
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
                }
                
                NavigationLink(destination: SavedAddressesView()) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 30)
                        Text("Manage Saved Places")
                            .font(.subheadline)
                    }
                }
            }
            
            // Payments
            Section(header: Text("Payments")) {
                NavigationLink(destination: PaymentMethodsView()) {
                    Label("Payment Methods", systemImage: "creditcard.fill")
                }
                NavigationLink(destination: WalletView()) {
                    Label("Wallet", systemImage: "wallet.pass.fill")
                }
            }
            
            // Appearance
            Section(header: Text("Appearance")) {
                NavigationLink(destination: ThemeSettingsView()) {
                    Label("Theme & Dark Mode", systemImage: "paintbrush.fill")
                }
                NavigationLink(destination: LanguageSelectionView()) {
                    HStack {
                        Label("Language", systemImage: "globe")
                        Spacer()
                        Text("English")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                NavigationLink(destination: AccessibilitySettingsView()) {
                    Label("Accessibility", systemImage: "accessibility")
                }
            }
            
            // Safety
            Section(header: Text("Safety")) {
                NavigationLink(destination: EmergencySOSView()) {
                    Label("Emergency SOS", systemImage: "sos.circle.fill")
                        .foregroundColor(.red)
                }
            }
            
            // General
            Section(header: Text("General")) {
                NavigationLink(destination: HelpSupportView()) {
                    Label("Help & Support", systemImage: "questionmark.circle.fill")
                }
                NavigationLink(destination: AboutView()) {
                    Label("About", systemImage: "info.circle.fill")
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
