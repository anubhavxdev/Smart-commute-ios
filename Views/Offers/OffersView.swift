import SwiftUI

struct OffersView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    let offers: [MockOffer] = [
        MockOffer(title: "50% OFF", subtitle: "On your first Bike ride", code: "FIRST50", gradient: [Color.purple, Color.pink]),
        MockOffer(title: "Flat ₹30 OFF", subtitle: "On Auto rides above ₹100", code: "AUTO30", gradient: [Color.blue, Color.cyan]),
        MockOffer(title: "Free Ride", subtitle: "Refer a friend & get a free ride", code: "REFER2026", gradient: [Color.orange, Color.red]),
        MockOffer(title: "20% Cashback", subtitle: "Pay via wallet & get cashback", code: "WALLET20", gradient: [Color.green, Color.teal]),
    ]
    
    @State private var copiedCode: String?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(offers) { offer in
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(offer.title)
                                .font(.system(size: 28, weight: .black))
                                .foregroundColor(.white)
                            
                            Text(offer.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            HStack {
                                Text(offer.code)
                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(Color.white.opacity(0.25))
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    withAnimation {
                                        copiedCode = offer.code
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation { copiedCode = nil }
                                    }
                                }) {
                                    Text(copiedCode == offer.code ? "Copied!" : "Apply")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(24)
                        .background(
                            LinearGradient(gradient: Gradient(colors: offer.gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .cornerRadius(20)
                        
                        Image(systemName: "tag.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white.opacity(0.15))
                            .padding(20)
                    }
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Offers")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct MockOffer: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let code: String
    let gradient: [Color]
}
