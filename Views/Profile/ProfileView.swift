import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var phone: String = "+91 98765 43210"
    @State private var email: String = ""
    @State private var emergencyContact: String = "+91 91234 56789"
    @State private var emergencyName: String = "Mom"
    @State private var gender: String = "Male"
    @State private var showImagePicker = false
    @State private var isSaved = false
    
    let brandYellow = Color.brand
    let genders = ["Male", "Female", "Non-binary", "Prefer not to say"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Picture
                VStack(spacing: 12) {
                    ZStack(alignment: .bottomTrailing) {
                        Circle()
                            .fill(LinearGradient(
                                colors: [brandYellow, brandYellow.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 110, height: 110)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.black.opacity(0.6))
                            )
                        
                        Button(action: { showImagePicker = true }) {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Image(systemName: "camera.fill")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                )
                                .shadow(color: .black.opacity(0.2), radius: 4)
                        }
                    }
                    
                    Text(name.isEmpty ? "Set your name" : name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 16) {
                        StatPill(icon: "star.fill", value: "4.85", label: "Rating")
                        StatPill(icon: "car.fill", value: "47", label: "Rides")
                        StatPill(icon: "calendar", value: "Mar '26", label: "Since")
                    }
                }
                .padding(.top, 10)
                
                // Personal Info
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Personal Information", icon: "person.text.rectangle.fill")
                    
                    ProfileField(label: "Full Name", text: $name, icon: "person.fill", placeholder: "Enter your name")
                    ProfileField(label: "Email", text: $email, icon: "envelope.fill", placeholder: "Email address")
                    ProfileField(label: "Phone", text: $phone, icon: "phone.fill", placeholder: "Phone number")
                    
                    // Gender picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Gender")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 8) {
                            ForEach(genders, id: \.self) { g in
                                Button(action: { withAnimation(.spring(response: 0.3)) { gender = g } }) {
                                    Text(g)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(gender == g ? brandYellow : Color.gray.opacity(0.08))
                                        .foregroundColor(.black)
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Emergency Contact
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Emergency Contact", icon: "sos.circle.fill")
                    
                    ProfileField(label: "Contact Name", text: $emergencyName, icon: "person.fill", placeholder: "Emergency contact name")
                    ProfileField(label: "Contact Number", text: $emergencyContact, icon: "phone.arrow.up.right.fill", placeholder: "Emergency number")
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Preferences
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Ride Preferences", icon: "slider.horizontal.3")
                    
                    PreferenceRow(icon: "music.note", title: "Music during ride", value: "Yes")
                    PreferenceRow(icon: "bubble.left.fill", title: "Chat preference", value: "Minimal")
                    PreferenceRow(icon: "thermometer.medium", title: "AC preference", value: "Cool")
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Save Button
                Button(action: {
                    withAnimation(.spring(response: 0.4)) {
                        isSaved = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation { isSaved = false }
                    }
                }) {
                    HStack {
                        Image(systemName: isSaved ? "checkmark.circle.fill" : "square.and.arrow.down.fill")
                        Text(isSaved ? "Saved!" : "Save Changes")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(brandYellow)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                
                // Delete Account
                Button(action: {}) {
                    Text("Delete Account")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
                .padding(.bottom, 30)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            name = authViewModel.email.components(separatedBy: "@").first?.capitalized ?? "User"
            email = authViewModel.email
        }
    }
}

// MARK: - Supporting Views
struct ProfileField: View {
    let label: String
    @Binding var text: String
    let icon: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.black.opacity(0.5))
                    .frame(width: 20)
                TextField(placeholder, text: $text)
                    .font(.subheadline)
            }
            .padding(12)
            .background(Color.gray.opacity(0.06))
            .cornerRadius(10)
        }
    }
}

struct StatPill: View {
    let icon: String
    let value: String
    let label: String
    let brandYellow = Color.brand
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(brandYellow)
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.06))
        .cornerRadius(10)
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.black.opacity(0.6))
            Text(title)
                .font(.headline)
        }
    }
}

struct PreferenceRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            Text(title)
                .font(.subheadline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundColor(.gray.opacity(0.5))
        }
    }
}
