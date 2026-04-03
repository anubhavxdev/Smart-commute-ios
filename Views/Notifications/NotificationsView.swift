import SwiftUI

struct NotificationItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let message: String
    let time: String
    let type: NotificationType
    var isRead: Bool
    
    enum NotificationType {
        case ride, promo, system, safety
    }
}

struct NotificationsView: View {
    @State private var selectedFilter = "All"
    let filters = ["All", "Rides", "Promos", "System"]
    
    let brandYellow = Color.brand
    
    @State private var notifications: [NotificationItem] = [
        NotificationItem(icon: "car.fill", title: "Ride Completed", message: "Your ride to Koramangala 5th Block has been completed. Fare: ₹45", time: "2 min ago", type: .ride, isRead: false),
        NotificationItem(icon: "tag.fill", title: "🎉 50% OFF your next ride!", message: "Use code FIRST50 on your next Bike ride. Valid till midnight!", time: "15 min ago", type: .promo, isRead: false),
        NotificationItem(icon: "shield.checkmark.fill", title: "Safety Update", message: "Emergency SOS feature is now active. Tap to set up emergency contacts.", time: "1 hr ago", type: .safety, isRead: false),
        NotificationItem(icon: "star.fill", title: "Rate your ride", message: "How was your ride with Raju Kumar? Rate now and help us improve.", time: "2 hrs ago", type: .ride, isRead: true),
        NotificationItem(icon: "wallet.pass.fill", title: "Cashback Credited!", message: "₹25 cashback has been credited to your SmartCommute wallet.", time: "3 hrs ago", type: .promo, isRead: true),
        NotificationItem(icon: "bell.badge.fill", title: "Scheduled Ride Reminder", message: "Your ride to Office is scheduled for tomorrow at 9:00 AM.", time: "5 hrs ago", type: .system, isRead: true),
        NotificationItem(icon: "person.2.fill", title: "Referral Bonus!", message: "Amit joined using your referral code. ₹100 credited!", time: "Yesterday", type: .promo, isRead: true),
        NotificationItem(icon: "exclamationmark.triangle.fill", title: "Route Change", message: "Heavy traffic on Silk Board. Driver taking alternate route.", time: "Yesterday", type: .ride, isRead: true),
        NotificationItem(icon: "app.badge.fill", title: "App Update Available", message: "SmartCommute v1.1 is available with new features. Update now!", time: "2 days ago", type: .system, isRead: true),
        NotificationItem(icon: "gift.fill", title: "Weekend Special", message: "Get flat ₹30 OFF on all Auto rides this weekend!", time: "3 days ago", type: .promo, isRead: true),
    ]
    
    var filteredNotifications: [NotificationItem] {
        switch selectedFilter {
        case "Rides": return notifications.filter { $0.type == .ride }
        case "Promos": return notifications.filter { $0.type == .promo }
        case "System": return notifications.filter { $0.type == .system || $0.type == .safety }
        default: return notifications
        }
    }
    
    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Unread count banner
            if unreadCount > 0 {
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 8, height: 8)
                    Text("\(unreadCount) unread notification\(unreadCount > 1 ? "s" : "")")
                        .font(.caption)
                        .fontWeight(.medium)
                    Spacer()
                    Button("Mark all read") {
                        withAnimation {
                            for i in notifications.indices {
                                notifications[i].isRead = true
                            }
                        }
                    }
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(brandYellow)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.blue.opacity(0.05))
            }
            
            // Filter chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) { selectedFilter = filter }
                        }) {
                            Text(filter)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(selectedFilter == filter ? .black : .gray)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 8)
                                .background(selectedFilter == filter ? brandYellow : Color.gray.opacity(0.1))
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            
            if filteredNotifications.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "bell.slash.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.3))
                    Text("No notifications")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredNotifications) { notification in
                            NotificationRow(notification: notification, brandYellow: brandYellow)
                                .onTapGesture {
                                    if let idx = notifications.firstIndex(where: { $0.id == notification.id }) {
                                        withAnimation { notifications[idx].isRead = true }
                                    }
                                }
                            
                            Divider().padding(.leading, 70)
                        }
                    }
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct NotificationRow: View {
    let notification: NotificationItem
    let brandYellow: Color
    
    var iconColor: Color {
        switch notification.type {
        case .ride: return .blue
        case .promo: return .orange
        case .system: return .purple
        case .safety: return .red
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: notification.icon)
                    .foregroundColor(iconColor)
                    .font(.subheadline)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.subheadline)
                        .fontWeight(notification.isRead ? .medium : .bold)
                    
                    Spacer()
                    
                    if !notification.isRead {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8, height: 8)
                    }
                }
                
                Text(notification.message)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text(notification.time)
                    .font(.caption2)
                    .foregroundColor(.gray.opacity(0.7))
                    .padding(.top, 2)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(notification.isRead ? Color.clear : brandYellow.opacity(0.04))
    }
}
