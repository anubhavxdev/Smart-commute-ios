import SwiftUI

struct EmergencyContact: Identifiable {
    let id = UUID()
    var name: String
    var phone: String
    var relationship: String
}

struct EmergencySOSView: View {
    let brandYellow = Color.brand
    
    @State private var contacts: [EmergencyContact] = [
        EmergencyContact(name: "Mom", phone: "+91 91234 56789", relationship: "Mother"),
        EmergencyContact(name: "Amit (Colleague)", phone: "+91 98765 12345", relationship: "Colleague"),
    ]
    
    @State private var shareLocation = true
    @State private var autoRecordRides = true
    @State private var showAddContact = false
    @State private var isPulsing = false
    @State private var showSOSActivated = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // SOS Button
                VStack(spacing: 16) {
                    ZStack {
                        // Pulse rings
                        Circle()
                            .stroke(Color.red.opacity(0.15), lineWidth: 3)
                            .frame(width: 180, height: 180)
                            .scaleEffect(isPulsing ? 1.3 : 1.0)
                            .opacity(isPulsing ? 0 : 1)
                            .animation(.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: isPulsing)
                        
                        Circle()
                            .stroke(Color.red.opacity(0.2), lineWidth: 3)
                            .frame(width: 160, height: 160)
                            .scaleEffect(isPulsing ? 1.2 : 1.0)
                            .opacity(isPulsing ? 0 : 1)
                            .animation(.easeOut(duration: 1.5).delay(0.3).repeatForever(autoreverses: false), value: isPulsing)
                        
                        // Main SOS button
                        Button(action: {
                            withAnimation(.spring()) { showSOSActivated = true }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.red, Color.red.opacity(0.8)],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 130, height: 130)
                                    .shadow(color: .red.opacity(0.4), radius: 20)
                                
                                VStack(spacing: 4) {
                                    Image(systemName: "sos.circle.fill")
                                        .font(.system(size: 40))
                                    Text("SOS")
                                        .font(.headline)
                                        .fontWeight(.black)
                                }
                                .foregroundColor(.white)
                            }
                        }
                    }
                    
                    Text("Press and hold for emergency")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("Will call 112 & alert your contacts")
                        .font(.caption)
                        .foregroundColor(.red.opacity(0.7))
                }
                .padding(30)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)
                .onAppear { isPulsing = true }
                
                // Emergency Contacts
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        HStack(spacing: 8) {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.red)
                            Text("Emergency Contacts")
                                .font(.headline)
                        }
                        Spacer()
                        Button(action: { showAddContact = true }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(brandYellow)
                        }
                    }
                    
                    ForEach(contacts) { contact in
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color.red.opacity(0.1))
                                    .frame(width: 44, height: 44)
                                Text(String(contact.name.prefix(1)))
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(contact.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("\(contact.phone) • \(contact.relationship)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "phone.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(14)
                        .background(Color.gray.opacity(0.04))
                        .cornerRadius(12)
                    }
                    
                    if contacts.count < 3 {
                        Text("You can add up to 3 emergency contacts")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Safety Features
                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 8) {
                        Image(systemName: "shield.checkmark.fill")
                            .foregroundColor(.green)
                        Text("Safety Features")
                            .font(.headline)
                    }
                    
                    Toggle(isOn: $shareLocation) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Share live location")
                                .font(.subheadline)
                            Text("Auto-share trip details with contacts")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .tint(.green)
                    
                    Toggle(isOn: $autoRecordRides) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Auto-record rides")
                                .font(.subheadline)
                            Text("Record audio during rides for safety")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .tint(.green)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Safety tips
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(brandYellow)
                        Text("Safety Tips")
                            .font(.headline)
                    }
                    
                    SafetyTip(icon: "checkmark.shield.fill", text: "Always verify driver name and plate number")
                    SafetyTip(icon: "square.and.arrow.up.fill", text: "Share your ride with a trusted contact")
                    SafetyTip(icon: "location.fill", text: "Ensure GPS is on during your ride")
                    SafetyTip(icon: "eye.fill", text: "Stay alert and aware of your route")
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Emergency SOS")
        .navigationBarTitleDisplayMode(.large)
        .alert("🚨 SOS Activated!", isPresented: $showSOSActivated) {
            Button("Call 112", role: .destructive) { }
            Button("Alert Contacts Only") { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Your live location will be shared with \(contacts.count) emergency contact(s). Do you want to call 112?")
        }
        .sheet(isPresented: $showAddContact) {
            AddContactSheet(contacts: $contacts, isPresented: $showAddContact, brandYellow: brandYellow)
        }
    }
}

struct SafetyTip: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.green)
                .frame(width: 20)
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct AddContactSheet: View {
    @Binding var contacts: [EmergencyContact]
    @Binding var isPresented: Bool
    let brandYellow: Color
    
    @State private var name = ""
    @State private var phone = ""
    @State private var relationship = "Family"
    
    let relationships = ["Family", "Friend", "Colleague", "Spouse", "Other"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Contact Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.08))
                    .cornerRadius(10)
                
                TextField("Phone Number", text: $phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.gray.opacity(0.08))
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Relationship")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(relationships, id: \.self) { rel in
                                Button(action: { relationship = rel }) {
                                    Text(rel)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(relationship == rel ? brandYellow : Color.gray.opacity(0.1))
                                        .cornerRadius(20)
                                }
                                .foregroundColor(.black)
                            }
                        }
                    }
                }
                
                Button(action: {
                    if !name.isEmpty && !phone.isEmpty {
                        contacts.append(EmergencyContact(name: name, phone: phone, relationship: relationship))
                        isPresented = false
                    }
                }) {
                    Text("Add Contact")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(brandYellow)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { isPresented = false }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
