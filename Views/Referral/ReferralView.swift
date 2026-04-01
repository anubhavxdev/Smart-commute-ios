import SwiftUI

struct ReferralView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    @State private var referralCode = "SMART2026X"
    @State private var isCopied = false
    
    let referrals: [ReferralEntry] = [
        ReferralEntry(name: "Amit Patel", date: "28 Mar", status: .completed, earned: 100),
        ReferralEntry(name: "Sneha Reddy", date: "25 Mar", status: .completed, earned: 100),
        ReferralEntry(name: "Rahul Verma", date: "22 Mar", status: .pending, earned: 0),
        ReferralEntry(name: "Priya S.", date: "20 Mar", status: .completed, earned: 100),
    ]
    
    var totalEarned: Int { referrals.filter { $0.status == .completed }.reduce(0) { $0 + $1.earned } }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Hero
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(brandYellow.opacity(0.15))
                            .frame(width: 100, height: 100)
                        Image(systemName: "gift.fill")
                            .font(.system(size: 44))
                            .foregroundColor(brandYellow)
                    }
                    
                    Text("Invite & Earn")
                        .font(.title)
                        .fontWeight(.black)
                    
                    Text("Invite friends & earn ₹100 for each successful referral")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    // Referral code
                    VStack(spacing: 10) {
                        Text("Your Referral Code")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 12) {
                            Text(referralCode)
                                .font(.system(size: 22, weight: .black, design: .monospaced))
                                .tracking(3)
                            
                            Button(action: {
                                withAnimation(.spring()) { isCopied = true }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation { isCopied = false }
                                }
                            }) {
                                Image(systemName: isCopied ? "checkmark.circle.fill" : "doc.on.doc.fill")
                                    .foregroundColor(isCopied ? .green : brandYellow)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(brandYellow.opacity(0.1))
                        .cornerRadius(14)
                    }
                }
                .padding(30)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)
                
                // Share buttons
                HStack(spacing: 12) {
                    ShareButton(icon: "message.fill", label: "WhatsApp", color: .green)
                    ShareButton(icon: "envelope.fill", label: "Email", color: .blue)
                    ShareButton(icon: "square.and.arrow.up.fill", label: "Share", color: .purple)
                    ShareButton(icon: "link", label: "Copy Link", color: .orange)
                }
                .padding(.horizontal)
                
                // How it works
                VStack(alignment: .leading, spacing: 16) {
                    Text("How it works")
                        .font(.headline)
                    
                    ReferralStep(step: 1, title: "Share your code", description: "Send your unique code to friends", icon: "square.and.arrow.up", color: .blue)
                    ReferralStep(step: 2, title: "Friend signs up", description: "They register using your code", icon: "person.badge.plus", color: .green)
                    ReferralStep(step: 3, title: "Complete a ride", description: "They complete their first ride", icon: "car.fill", color: .orange)
                    ReferralStep(step: 4, title: "Both earn ₹100", description: "Credits added to both wallets!", icon: "gift.fill", color: .purple)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Earnings
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Text("Your Referrals")
                            .font(.headline)
                        Spacer()
                        Text("Total: ₹\(totalEarned)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    ForEach(referrals) { ref in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(ref.status == .completed ? Color.green.opacity(0.1) : Color.orange.opacity(0.1))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Text(String(ref.name.prefix(1)))
                                        .fontWeight(.bold)
                                        .foregroundColor(ref.status == .completed ? .green : .orange)
                                )
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(ref.name)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text(ref.date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            if ref.status == .completed {
                                Text("+₹\(ref.earned)")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            } else {
                                Text("Pending")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.orange.opacity(0.1))
                                    .cornerRadius(6)
                            }
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Refer & Earn")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ReferralEntry: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let status: ReferralStatus
    let earned: Int
    
    enum ReferralStatus {
        case completed, pending
    }
}

struct ShareButton: View {
    let icon: String
    let label: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(color)
                    .clipShape(Circle())
                Text(label)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ReferralStep: View {
    let step: Int
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.subheadline)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(step). \(title)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
