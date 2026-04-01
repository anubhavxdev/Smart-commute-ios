import SwiftUI

struct HelpSupportView: View {
    @State private var searchText = ""
    @State private var expandedFAQ: UUID?
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    let faqCategories: [FAQCategory] = [
        FAQCategory(name: "Ride Issues", icon: "car.fill", color: .blue, faqs: [
            FAQ(question: "My driver didn't arrive", answer: "If your driver didn't arrive, you won't be charged. The ride will be automatically cancelled after the wait time expires. You can rebook immediately."),
            FAQ(question: "I was charged extra", answer: "Extra charges may apply for waiting time, toll charges, or route deviations. You can view the fare breakdown in your ride history. If the charge seems incorrect, raise a dispute."),
            FAQ(question: "I left something in the vehicle", answer: "Go to your ride history, select the ride, and tap 'Report Issue'. Choose 'Lost Item' and we'll connect you with the driver."),
        ]),
        FAQCategory(name: "Payments", icon: "indianrupeesign.circle.fill", color: .green, faqs: [
            FAQ(question: "Refund not received", answer: "Refunds are processed within 5-7 business days. Check your wallet first — some refunds are credited there. If it's been longer, contact support."),
            FAQ(question: "How to add money to wallet", answer: "Go to Wallet > Add Money. You can add using UPI, debit/credit card, or net banking. Minimum add amount is ₹100."),
            FAQ(question: "Payment failed but money deducted", answer: "Don't worry! If the payment failed, the amount will be automatically refunded within 24-48 hours."),
        ]),
        FAQCategory(name: "Account", icon: "person.circle.fill", color: .purple, faqs: [
            FAQ(question: "How to change my phone number", answer: "Go to Settings > Edit Profile > Phone. You'll need to verify the new number with OTP."),
            FAQ(question: "How to delete my account", answer: "Go to Settings > Edit Profile > Delete Account. Note: this action is irreversible and all your data will be permanently removed."),
        ]),
        FAQCategory(name: "Safety", icon: "shield.checkmark.fill", color: .red, faqs: [
            FAQ(question: "How does the SOS feature work?", answer: "Press the SOS button during an active ride. It will share your live location with your emergency contacts and optionally call 112 (police)."),
            FAQ(question: "How to add emergency contacts", answer: "Go to Profile > Emergency Contact. You can add up to 3 emergency contacts who will receive your ride details."),
        ]),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Search bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search for help...", text: $searchText)
                        .font(.subheadline)
                }
                .padding(14)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 5)
                .padding(.horizontal)
                
                // Quick Actions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Quick Actions")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            QuickActionCard(icon: "bubble.left.and.bubble.right.fill", title: "Live Chat", subtitle: "Chat with us", color: .blue)
                            QuickActionCard(icon: "phone.fill", title: "Call Us", subtitle: "1800-XXX-XXXX", color: .green)
                            QuickActionCard(icon: "envelope.fill", title: "Email", subtitle: "support@sc.com", color: .orange)
                            QuickActionCard(icon: "doc.text.fill", title: "Raise Ticket", subtitle: "Track issue", color: .purple)
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Recent Ride Issue
                VStack(alignment: .leading, spacing: 12) {
                    Text("Issue with recent ride?")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(brandYellow.opacity(0.15))
                                .frame(width: 48, height: 48)
                            Image(systemName: "car.fill")
                                .foregroundColor(.black)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Koramangala 5th Block")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Today, 9:30 AM • ₹45")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button("Report") {
                            // Report action
                        }
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(brandYellow)
                        .cornerRadius(8)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(14)
                    .padding(.horizontal)
                }
                
                // FAQ Sections
                VStack(alignment: .leading, spacing: 16) {
                    Text("Frequently Asked Questions")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(faqCategories) { category in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 10) {
                                Image(systemName: category.icon)
                                    .foregroundColor(category.color)
                                Text(category.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            
                            ForEach(filteredFAQs(from: category.faqs)) { faq in
                                VStack(alignment: .leading, spacing: 0) {
                                    Button(action: {
                                        withAnimation(.spring(response: 0.3)) {
                                            expandedFAQ = expandedFAQ == faq.id ? nil : faq.id
                                        }
                                    }) {
                                        HStack {
                                            Text(faq.question)
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                            Image(systemName: expandedFAQ == faq.id ? "chevron.up" : "chevron.down")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                    }
                                    
                                    if expandedFAQ == faq.id {
                                        Text(faq.answer)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 16)
                                            .padding(.bottom, 12)
                                            .transition(.opacity.combined(with: .move(edge: .top)))
                                    }
                                    
                                    Divider().padding(.leading, 16)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(14)
                        .padding(.horizontal)
                    }
                }
                
                // Still need help
                VStack(spacing: 12) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(brandYellow)
                    
                    Text("Still need help?")
                        .font(.headline)
                    
                    Text("Our support team is available 24/7")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Button(action: {}) {
                        Text("Contact Support")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(brandYellow)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Help & Support")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func filteredFAQs(from faqs: [FAQ]) -> [FAQ] {
        if searchText.isEmpty { return faqs }
        return faqs.filter {
            $0.question.localizedCaseInsensitiveContains(searchText) ||
            $0.answer.localizedCaseInsensitiveContains(searchText)
        }
    }
}

// MARK: - Models
struct FAQCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let faqs: [FAQ]
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct QuickActionCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 100)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.04), radius: 5)
    }
}
