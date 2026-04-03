import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isShowing: Bool
    @Binding var navigateTo: AppDestination?
    
    let brandYellow = Color.brand
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isShowing = false
                    }
                }
            
            // Menu panel
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    // Profile header
                    VStack(alignment: .leading, spacing: 10) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        
                        Text(authViewModel.email.components(separatedBy: "@").first?.capitalized ?? "User")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("+91 98765 43210")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(brandYellow)
                                .font(.caption)
                            Text("4.85")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 4)
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black)
                    
                    // Menu items
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            MenuRow(icon: "person.crop.circle.fill", title: "My Profile") {
                                navigateTo = .profile
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "clock.arrow.circlepath", title: "My Rides") {
                                navigateTo = .rideHistory
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "wallet.pass.fill", title: "Wallet") {
                                navigateTo = .wallet
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "creditcard.fill", title: "Payment Methods") {
                                navigateTo = .paymentMethods
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "tag.fill", title: "Offers & Coupons") {
                                navigateTo = .offers
                                withAnimation { isShowing = false }
                            }
                            
                            Divider().padding(.horizontal)
                            
                            MenuSectionLabel(title: "COMMUTE TOOLS")
                            
                            MenuRow(icon: "calendar.badge.clock", title: "Schedule Ride") {
                                navigateTo = .scheduleRide
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "point.3.connected.trianglepath.dotted", title: "Multi-Stop Ride") {
                                navigateTo = .multiStop
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "person.2.fill", title: "Ride Sharing") {
                                navigateTo = .rideSharing
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "calculator", title: "Fare Estimator") {
                                navigateTo = .fareEstimator
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "mappin.and.ellipse", title: "Saved Addresses") {
                                navigateTo = .savedAddresses
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "heart.fill", title: "Favorite Drivers") {
                                navigateTo = .favoriteDrivers
                                withAnimation { isShowing = false }
                            }
                            
                            Divider().padding(.horizontal)
                            
                            MenuSectionLabel(title: "CORPORATE & INSIGHTS")
                            
                            MenuRow(icon: "building.2.fill", title: "Corporate Dashboard") {
                                navigateTo = .corporate
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "chart.bar.fill", title: "Commute Insights") {
                                navigateTo = .insights
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "gift.fill", title: "Refer & Earn") {
                                navigateTo = .referral
                                withAnimation { isShowing = false }
                            }
                            
                            Divider().padding(.horizontal)
                            
                            MenuSectionLabel(title: "MORE")
                            
                            MenuRow(icon: "bell.fill", title: "Notifications") {
                                navigateTo = .notifications
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "sos.circle.fill", title: "Emergency SOS") {
                                navigateTo = .emergencySOS
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "gearshape.fill", title: "Settings") {
                                navigateTo = .settings
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "questionmark.circle.fill", title: "Help & Support") {
                                navigateTo = .helpSupport
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "info.circle.fill", title: "About") {
                                navigateTo = .about
                                withAnimation { isShowing = false }
                            }
                            
                            Divider().padding(.horizontal)
                            
                            MenuRow(icon: "rectangle.portrait.and.arrow.right", title: "Logout", isDestructive: true) {
                                withAnimation {
                                    isShowing = false
                                    authViewModel.isLoggedIn = false
                                }
                            }
                        }
                    }
                    
                    // App version
                    Text("SmartCommute v1.0.0")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding()
                }
                .frame(width: 280)
                .background(Color.white)
                
                Spacer()
            }
            .transition(.move(edge: .leading))
        }
    }
}

struct MenuRow: View {
    let icon: String
    let title: String
    var isDestructive: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(isDestructive ? .red : .black)
                    .frame(width: 30)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(isDestructive ? .red : .primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 16)
        }
    }
}

enum AppDestination {
    case rideHistory
    case wallet
    case offers
    case settings
    case profile
    case notifications
    case helpSupport
    case about
    case savedAddresses
    case scheduleRide
    case rideSharing
    case emergencySOS
    case paymentMethods
    case fareEstimator
    case corporate
    case insights
    case referral
    case favoriteDrivers
    case multiStop
    case accessibility
    case language
    case theme
}

struct MenuSectionLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.caption2)
            .fontWeight(.bold)
            .foregroundColor(.gray.opacity(0.7))
            .padding(.horizontal, 25)
            .padding(.top, 12)
            .padding(.bottom, 4)
    }
}
