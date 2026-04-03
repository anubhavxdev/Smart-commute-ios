import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
    let gradient: [Color]
}

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    @State private var currentPage = 0
    
    let brandYellow = Color.brand
    
    let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "bicycle",
            title: "Quick Rides",
            subtitle: "Book bikes, autos & cabs in seconds.\nSmartCommute gets your ride in under 3 minutes.",
            gradient: [Color(red: 0.98, green: 0.79, blue: 0.21), Color.orange]
        ),
        OnboardingPage(
            icon: "mappin.and.ellipse",
            title: "Live Tracking",
            subtitle: "Track your ride in real-time.\nShare your trip with loved ones for safety.",
            gradient: [Color.blue, Color.cyan]
        ),
        OnboardingPage(
            icon: "building.2.fill",
            title: "Corporate Commute",
            subtitle: "Manage your daily office commute.\nUsing your company ride allowance seamlessly.",
            gradient: [Color.purple, Color.pink]
        ),
        OnboardingPage(
            icon: "wallet.pass.fill",
            title: "Smart Payments",
            subtitle: "Pay via wallet, UPI, or corporate billing.\nEarn cashback and rewards on every ride.",
            gradient: [Color.green, Color.teal]
        ),
    ]
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: pages[currentPage].gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.5), value: currentPage)
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    if currentPage < pages.count - 1 {
                        Button(action: {
                            withAnimation { hasSeenOnboarding = true }
                        }) {
                            Text("Skip")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                // Page content
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                        VStack(spacing: 30) {
                            // Icon with glow
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.15))
                                    .frame(width: 180, height: 180)
                                
                                Circle()
                                    .fill(Color.white.opacity(0.25))
                                    .frame(width: 140, height: 140)
                                
                                Image(systemName: page.icon)
                                    .font(.system(size: 60, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(spacing: 14) {
                                Text(page.title)
                                    .font(.system(size: 32, weight: .black))
                                    .foregroundColor(.white)
                                
                                Text(page.subtitle)
                                    .font(.body)
                                    .foregroundColor(.white.opacity(0.85))
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(4)
                            }
                            .padding(.horizontal, 30)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer()
                
                // Bottom section
                VStack(spacing: 24) {
                    // Page indicators
                    HStack(spacing: 10) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Capsule()
                                .fill(Color.white.opacity(index == currentPage ? 1 : 0.3))
                                .frame(width: index == currentPage ? 28 : 8, height: 8)
                                .animation(.spring(response: 0.4), value: currentPage)
                        }
                    }
                    
                    // Action button
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                            if currentPage < pages.count - 1 {
                                currentPage += 1
                            } else {
                                hasSeenOnboarding = true
                            }
                        }
                    }) {
                        HStack {
                            Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                                .fontWeight(.bold)
                            
                            Image(systemName: currentPage == pages.count - 1 ? "arrow.right.circle.fill" : "arrow.right")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.bottom, 50)
            }
        }
    }
}
