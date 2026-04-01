import SwiftUI

struct ContentRouterView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var hasSeenOnboarding = false
    
    var body: some View {
        if !hasSeenOnboarding {
            OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
        } else if authViewModel.isLoggedIn {
            DashboardView()
                .environmentObject(authViewModel)
        } else {
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}
