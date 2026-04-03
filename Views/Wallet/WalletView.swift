import SwiftUI

struct WalletView: View {
    let brandYellow = Color.brand
    @State private var balance: Int = 250
    
    let transactions: [WalletTransaction] = [
        WalletTransaction(title: "Ride to Koramangala", type: .debit, amount: 45, date: "28 Mar", icon: "bicycle"),
        WalletTransaction(title: "Added Money", type: .credit, amount: 500, date: "27 Mar", icon: "plus.circle.fill"),
        WalletTransaction(title: "Ride to Airport", type: .debit, amount: 380, date: "27 Mar", icon: "car.fill"),
        WalletTransaction(title: "Cashback Reward", type: .credit, amount: 25, date: "26 Mar", icon: "gift.fill"),
        WalletTransaction(title: "Ride to MG Road", type: .debit, amount: 65, date: "26 Mar", icon: "car.2.fill"),
        WalletTransaction(title: "Referral Bonus", type: .credit, amount: 100, date: "25 Mar", icon: "person.2.fill"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Balance Card
                VStack(spacing: 16) {
                    Text("Wallet Balance")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.6))
                    
                    Text("₹\(balance)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.black)
                    
                    // Quick add
                    HStack(spacing: 12) {
                        ForEach([100, 200, 500], id: \.self) { amount in
                            Button(action: {
                                withAnimation(.spring()) {
                                    balance += amount
                                }
                            }) {
                                Text("+₹\(amount)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(brandYellow)
                .cornerRadius(24)
                .padding(.horizontal)
                
                // Transactions
                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent Transactions")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(transactions) { txn in
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(txn.type == .credit ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                                    .frame(width: 44, height: 44)
                                
                                Image(systemName: txn.icon)
                                    .foregroundColor(txn.type == .credit ? .green : .red)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(txn.title)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text(txn.date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text("\(txn.type == .credit ? "+" : "-")₹\(txn.amount)")
                                .font(.headline)
                                .foregroundColor(txn.type == .credit ? .green : .red)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Wallet")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct WalletTransaction: Identifiable {
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Int
    let date: String
    let icon: String
}

enum TransactionType {
    case credit, debit
}
