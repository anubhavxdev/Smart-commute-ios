import SwiftUI

struct ActionCard: View {
    let title: String
    let iconName: String
    let action: () -> Void
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(brandYellow.opacity(0.15))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
                
                Text(title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

struct ActionCard_Previews: PreviewProvider {
    static var previews: some View {
        ActionCard(title: "Bike", iconName: "bicycle") {}
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
