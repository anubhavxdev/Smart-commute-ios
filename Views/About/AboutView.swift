import SwiftUI

struct AboutView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    @State private var showTerms = false
    @State private var showPrivacy = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // App Logo & Info
                VStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(brandYellow)
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "bicycle")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundColor(.black)
                    }
                    
                    Text("SmartCommute")
                        .font(.title)
                        .fontWeight(.black)
                    
                    Text("Version 1.0.0 (Build 42)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("Your ride, your way")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                
                // Stats
                HStack(spacing: 0) {
                    AboutStat(value: "500K+", label: "Users", icon: "person.3.fill")
                    Divider().frame(height: 40)
                    AboutStat(value: "10M+", label: "Rides", icon: "car.fill")
                    Divider().frame(height: 40)
                    AboutStat(value: "50+", label: "Cities", icon: "map.fill")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Mission
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        Text("Our Mission")
                            .font(.headline)
                    }
                    
                    Text("SmartCommute is reimagining how employees commute to work. We believe your daily commute should be stress-free, affordable, and sustainable. By connecting riders and drivers intelligently, we're building a future where every commute is a smart commute.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Links
                VStack(spacing: 0) {
                    AboutLinkRow(icon: "doc.text.fill", title: "Terms of Service", color: .blue) {
                        showTerms = true
                    }
                    Divider().padding(.leading, 50)
                    
                    AboutLinkRow(icon: "lock.shield.fill", title: "Privacy Policy", color: .green) {
                        showPrivacy = true
                    }
                    Divider().padding(.leading, 50)
                    
                    AboutLinkRow(icon: "building.columns.fill", title: "Licenses", color: .orange) { }
                    Divider().padding(.leading, 50)
                    
                    AboutLinkRow(icon: "star.fill", title: "Rate Us on App Store", color: .yellow) { }
                    Divider().padding(.leading, 50)
                    
                    AboutLinkRow(icon: "square.and.arrow.up.fill", title: "Share SmartCommute", color: .purple) { }
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Social Links
                VStack(spacing: 14) {
                    Text("Follow Us")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 20) {
                        SocialIcon(name: "link", label: "Website")
                        SocialIcon(name: "bubble.left.fill", label: "Twitter")
                        SocialIcon(name: "camera.fill", label: "Instagram")
                        SocialIcon(name: "play.rectangle.fill", label: "YouTube")
                    }
                }
                .padding()
                
                // Footer
                VStack(spacing: 6) {
                    Text("Made with ❤️ in Bangalore")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("© 2026 SmartCommute Technologies Pvt. Ltd.")
                        .font(.caption2)
                        .foregroundColor(.gray.opacity(0.7))
                }
                .padding(.bottom, 30)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showTerms) {
            LegalDocView(title: "Terms of Service", content: termsContent)
        }
        .sheet(isPresented: $showPrivacy) {
            LegalDocView(title: "Privacy Policy", content: privacyContent)
        }
    }
    
    var termsContent: String {
        """
        Last updated: March 2026
        
        1. ACCEPTANCE OF TERMS
        By using SmartCommute, you agree to these Terms of Service. If you do not agree, please do not use our services.
        
        2. SERVICE DESCRIPTION
        SmartCommute provides a platform connecting riders with drivers for transportation services. We do not provide transportation services directly.
        
        3. USER RESPONSIBILITIES
        - Provide accurate personal information
        - Maintain the security of your account
        - Comply with all applicable laws
        - Treat drivers with respect
        
        4. PAYMENTS
        All fares are calculated based on distance, time, and demand. Prices are displayed before booking confirmation.
        
        5. CANCELLATION POLICY
        Free cancellation within 2 minutes of booking. Late cancellation may incur a fee.
        
        6. LIABILITY
        SmartCommute is not liable for any direct, indirect, or consequential damages arising from the use of our services.
        """
    }
    
    var privacyContent: String {
        """
        Last updated: March 2026
        
        1. INFORMATION WE COLLECT
        - Personal info: name, email, phone number
        - Location data during active rides
        - Payment information (processed securely)
        - Usage analytics
        
        2. HOW WE USE YOUR DATA
        - To provide and improve ride services
        - To process payments
        - To ensure safety and security
        - To send relevant notifications
        
        3. DATA SHARING
        We share limited data with drivers for ride fulfillment. We do not sell your personal data to third parties.
        
        4. DATA SECURITY
        We employ industry-standard encryption and security measures to protect your information.
        
        5. YOUR RIGHTS
        You can access, modify, or delete your data at any time through the app settings.
        """
    }
}

struct AboutStat: View {
    let value: String
    let label: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct AboutLinkRow: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 24)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
    }
}

struct SocialIcon: View {
    let name: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: name)
                .font(.title3)
                .foregroundColor(.black)
                .frame(width: 44, height: 44)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

struct LegalDocView: View {
    let title: String
    let content: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(content)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineSpacing(4)
                    .padding()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
