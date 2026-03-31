import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var isShowing: Bool
    @Binding var navigateTo: AppDestination?
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
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
                            MenuRow(icon: "clock.arrow.circlepath", title: "My Rides") {
                                navigateTo = .rideHistory
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "wallet.pass.fill", title: "Wallet") {
                                navigateTo = .wallet
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "tag.fill", title: "Offers & Coupons") {
                                navigateTo = .offers
                                withAnimation { isShowing = false }
                            }
                            
                            Divider().padding(.horizontal)
                            
                            MenuRow(icon: "gearshape.fill", title: "Settings") {
                                navigateTo = .settings
                                withAnimation { isShowing = false }
                            }
                            
                            MenuRow(icon: "questionmark.circle.fill", title: "Help & Support") { }
                            
                            MenuRow(icon: "info.circle.fill", title: "About") { }
                            
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
}
