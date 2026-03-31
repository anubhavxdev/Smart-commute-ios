import SwiftUI

struct RatingView: View {
    @Binding var showRating: Bool
    var driverName: String
    var onSubmit: () -> Void
    
    @State private var rating: Int = 0
    @State private var feedback: String = ""
    @State private var selectedTip: Int? = nil
    
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    let tips = [10, 20, 50]
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("Rate your ride with")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(driverName)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                // Stars
                HStack(spacing: 16) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= rating ? "star.fill" : "star")
                            .font(.system(size: 36))
                            .foregroundColor(star <= rating ? brandYellow : .gray.opacity(0.3))
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3)) {
                                    rating = star
                                }
                            }
                            .scaleEffect(star <= rating ? 1.1 : 1.0)
                    }
                }
                
                // Feedback
                TextField("Tell us about your ride (optional)", text: $feedback, axis: .vertical)
                    .lineLimit(3)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                
                // Tip section
                VStack(spacing: 12) {
                    Text("Add a tip for \(driverName.components(separatedBy: " ").first ?? "driver")?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 12) {
                        ForEach(tips, id: \.self) { amount in
                            Button(action: {
                                withAnimation {
                                    selectedTip = selectedTip == amount ? nil : amount
                                }
                            }) {
                                Text("₹\(amount)")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(selectedTip == amount ? brandYellow : Color.gray.opacity(0.1))
                                    .foregroundColor(selectedTip == amount ? .black : .primary)
                                    .cornerRadius(12)
                            }
                        }
                    }
                }
                
                // Submit
                Button(action: {
                    withAnimation {
                        showRating = false
                        onSubmit()
                    }
                }) {
                    Text("Submit Rating")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(brandYellow)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    withAnimation {
                        showRating = false
                        onSubmit()
                    }
                }) {
                    Text("Skip")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: -10)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color.black.opacity(0.4).ignoresSafeArea())
    }
}
