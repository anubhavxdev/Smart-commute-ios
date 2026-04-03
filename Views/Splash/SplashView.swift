import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.0
    
    let brandYellow = Color.brand
    
    var body: some View {
        if isActive {
            ContentRouterView()
        } else {
            ZStack {
                brandYellow.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image(systemName: "bicycle")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("SmartCommute")
                        .font(.system(size: 36, weight: .black))
                        .foregroundColor(.black)
                        .tracking(-0.5)
                    
                    Text("Your ride, your way")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.6))
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        scale = 1.0
                        opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
