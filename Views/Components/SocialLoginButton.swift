import SwiftUI

struct SocialLoginButton: View {
    let iconName: String
    let title: String
    
    var body: some View {
        Button(action: {
            // Placeholder action
        }) {
            HStack {
                Image(systemName: iconName)
                    .font(.title3)
                Text(title)
                    .fontWeight(.medium)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
