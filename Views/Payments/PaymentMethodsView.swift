import SwiftUI

struct PaymentMethod: Identifiable {
    let id = UUID()
    let type: PaymentType
    let name: String
    let detail: String
    let icon: String
    var isDefault: Bool
    
    enum PaymentType {
        case upi, card, wallet, corporate
    }
}

struct PaymentMethodsView: View {
    let brandYellow = Color(red: 0.98, green: 0.79, blue: 0.21)
    
    @State private var methods: [PaymentMethod] = [
        PaymentMethod(type: .upi, name: "Google Pay", detail: "user@okicici", icon: "indianrupeesign.circle.fill", isDefault: true),
        PaymentMethod(type: .upi, name: "PhonePe", detail: "user@ybl", icon: "indianrupeesign.circle.fill", isDefault: false),
        PaymentMethod(type: .card, name: "HDFC Credit Card", detail: "•••• •••• •••• 4521", icon: "creditcard.fill", isDefault: false),
        PaymentMethod(type: .card, name: "SBI Debit Card", detail: "•••• •••• •••• 8734", icon: "creditcard.fill", isDefault: false),
        PaymentMethod(type: .wallet, name: "SmartCommute Wallet", detail: "Balance: ₹250", icon: "wallet.pass.fill", isDefault: false),
        PaymentMethod(type: .corporate, name: "Corporate Account", detail: "TechCorp Pvt. Ltd.", icon: "building.2.fill", isDefault: false),
    ]
    
    @State private var showAddSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Default payment
                if let defaultMethod = methods.first(where: { $0.isDefault }) {
                    VStack(spacing: 12) {
                        Text("DEFAULT PAYMENT")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(brandYellow.opacity(0.15))
                                    .frame(width: 50, height: 50)
                                Image(systemName: defaultMethod.icon)
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(defaultMethod.name)
                                    .font(.headline)
                                Text(defaultMethod.detail)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(brandYellow, lineWidth: 2)
                            )
                    )
                    .padding(.horizontal)
                }
                
                // UPI Methods
                PaymentSection(
                    title: "UPI",
                    icon: "indianrupeesign.circle.fill",
                    color: .purple,
                    methods: methods.filter { $0.type == .upi },
                    brandYellow: brandYellow,
                    onSetDefault: setDefault
                )
                
                // Cards
                PaymentSection(
                    title: "Cards",
                    icon: "creditcard.fill",
                    color: .blue,
                    methods: methods.filter { $0.type == .card },
                    brandYellow: brandYellow,
                    onSetDefault: setDefault
                )
                
                // Wallet
                PaymentSection(
                    title: "Wallet",
                    icon: "wallet.pass.fill",
                    color: .orange,
                    methods: methods.filter { $0.type == .wallet },
                    brandYellow: brandYellow,
                    onSetDefault: setDefault
                )
                
                // Corporate
                PaymentSection(
                    title: "Corporate",
                    icon: "building.2.fill",
                    color: .teal,
                    methods: methods.filter { $0.type == .corporate },
                    brandYellow: brandYellow,
                    onSetDefault: setDefault
                )
                
                // Add new
                Button(action: { showAddSheet = true }) {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(brandYellow.opacity(0.15))
                                .frame(width: 44, height: 44)
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                        }
                        
                        Text("Add Payment Method")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.black)
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(14)
                }
                .padding(.horizontal)
                
                // Security note
                HStack(spacing: 10) {
                    Image(systemName: "lock.shield.fill")
                        .foregroundColor(.green)
                    Text("Your payment information is encrypted and secure")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Payment Methods")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddSheet) {
            AddPaymentSheet(brandYellow: brandYellow, isPresented: $showAddSheet)
        }
    }
    
    func setDefault(_ id: UUID) {
        withAnimation(.spring(response: 0.3)) {
            for i in methods.indices {
                methods[i].isDefault = methods[i].id == id
            }
        }
    }
}

struct PaymentSection: View {
    let title: String
    let icon: String
    let color: Color
    let methods: [PaymentMethod]
    let brandYellow: Color
    let onSetDefault: (UUID) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            ForEach(methods) { method in
                HStack(spacing: 14) {
                    Image(systemName: method.icon)
                        .foregroundColor(color.opacity(0.7))
                        .frame(width: 24)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(method.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        Text(method.detail)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    if method.isDefault {
                        Text("Default")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(4)
                    }
                    
                    Menu {
                        Button("Set as Default") { onSetDefault(method.id) }
                        Button("Remove", role: .destructive) { }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                if method.id != methods.last?.id {
                    Divider().padding(.leading, 54)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(14)
        .padding(.horizontal)
    }
}

struct AddPaymentSheet: View {
    let brandYellow: Color
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                AddPaymentOption(icon: "indianrupeesign.circle.fill", title: "Add UPI ID", subtitle: "Link your UPI payment", color: .purple)
                AddPaymentOption(icon: "creditcard.fill", title: "Add Card", subtitle: "Credit or Debit card", color: .blue)
                AddPaymentOption(icon: "building.columns.fill", title: "Net Banking", subtitle: "Direct bank transfer", color: .green)
                AddPaymentOption(icon: "building.2.fill", title: "Corporate Account", subtitle: "Link company billing", color: .teal)
                Spacer()
            }
            .padding()
            .navigationTitle("Add Payment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { isPresented = false }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

struct AddPaymentOption: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .foregroundColor(.primary)
            .padding(16)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}
