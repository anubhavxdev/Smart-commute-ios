# SmartCommute

<div align="center">
  <img src="https://img.icons8.com/color/96/motorcycle.png" alt="SmartCommute" width="80" style="margin-bottom: 20px"/>
</div>

## Ride anywhere. Built in SwiftUI.

<div align="center">
  
[Explore on GitHub](https://github.com/anubhavxdev/Smart-commute-ios) — [View Demo](#) — [Read More](#features)

</div>

---

### Built for every commute.

SmartCommute is a beautiful, full-featured ride-hailing app designed and built entirely in SwiftUI. From your first ride to your daily commute, everything flows naturally.

**35+ meticulously crafted screens** — designed to get you where you're going, fast.

---

## What you can do.

<table>
  <tr>
    <td width="50%">
      <h3>📍 Book a ride in seconds</h3>
      <p>Map-first interface. Find your pickup and destination. See drivers around you. Book instantly.</p>
    </td>
    <td width="50%">
      <h3>🗺️ Track your driver live</h3>
      <p>Watch in real time as your driver arrives. See the exact route. Know your ETA down to the minute.</p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <h3>💳 Pay your way</h3>
      <p>Multiple payment methods built in. UPI. Cards. Wallet. Whatever works for you.</p>
    </td>
    <td width="50%">
      <h3>📅 Plan ahead</h3>
      <p>Schedule rides days in advance. Set them to repeat on weekdays. No scrambling at rush hour.</p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <h3>🚗 Share the ride</h3>
      <p>Carpool with colleagues on the same route. Save money. Save the planet.</p>
    </td>
    <td width="50%">
      <h3>🎨 Customize everything</h3>
      <p>Dark mode. Light mode. 11 Indian languages. Accessibility for everyone.</p>
    </td>
  </tr>
</table>

---

## Features that matter.

### 🔐 Authentication
- Seamless email/password login
- OTP verification with auto-advancing input
- Real-time validation & error handling

### 🗺️ Smart Maps
- Edge-to-edge interactive map
- 10 live drivers with real-time positions
- Route polylines with precise distance calculation
- Custom pickup and drop pins

### 🎯 Booking Made Simple
- Full-screen location search
- 10 predefined Bangalore locations
- Saved places (Home, Office) for quick access
- Vehicle choice: Bike, Auto, Cab, Parcel

### 💰 Transparent Fares
- Dynamic pricing based on actual distance
- Detailed fare breakdown with GST
- Fare comparisons across vehicle types
- Popular route suggestions

### 📡 Live Tracking
- Real-time driver movement on map
- Animated progress visualization
- ETA countdown
- One-tap SOS, Call, Chat, Share

### 📍 Multi-Stop Rides
- Add up to 3 intermediate stops
- Timeline visualization
- Per-stop fare estimation

### 📊 Ride History & Insights
- Past rides with filters & search
- Detailed trip receipts
- Weekly spending analytics
- Vehicle usage breakdown
- Environmental impact tracking

### 💼 Wallet & Payments
- Multiple payment methods
- Transaction history
- Smart defaults & quick access
- Corporate billing support

### 🛠️ Commute Tools
- Fare estimator
- Ride scheduling with recurring options
- Favorite drivers management
- Saved addresses with custom icons

### 🏢 Corporate Dashboard
- Budget tracking
- Team activity leaderboard
- Expense reports
- Company policy management

### 🌍 Customization
- Dark mode, Light mode, System
- Accent color picker
- 11 language support with progress indicators
- Accessibility settings: font size, contrast, presets

### 📞 Support
- Searchable FAQ
- Quick-action support (Chat, Call, Email, Ticket)
- Help & emergency contacts
- In-app issue reporting

---

## Built with SwiftUI.

Every pixel. Every interaction. Every animation. Built entirely in Apple's modern UI framework.

```swift
@StateObject var viewModel = DashboardViewModel()
@State var showLocationSearch = false

var body: some View {
    ZStack {
        // Map-first interface
        RouteMapView(pickup: $viewModel.pickup, destination: $viewModel.destination)
            .ignoresSafeArea()
        
        // Floating actions with glassmorphism
        VStack {
            HStack {
                Button(action: { showLocationSearch = true }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16, weight: .semibold))
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .sheet(isPresented: $showLocationSearch) {
            LocationSearchView(pickup: $viewModel.pickup, destination: $viewModel.destination)
        }
    }
}
```

The result? **Smooth. Fast. Responsive.** No compromise.

---

## Designed for iOS 17+.

Built with the latest iOS capabilities:

- **NavigationStack** for fluid navigation across 35+ screens
- **MKMapView** via UIViewRepresentable for powerful mapping
- **async/await** for modern networking
- **MVVM + State Machine** for predictable app state
- **@EnvironmentObject** for shared auth state
- **Glassmorphism** effects with `.ultraThinMaterial`
- **Spring animations** and custom transitions

---

## Tech Stack.

<div align="center">

### Frontend
<div style="display: flex; justify-content: center; gap: 20px; flex-wrap: wrap; margin: 20px 0;">
  <a href="https://developer.apple.com/xcode/swiftui/" target="_blank">
    <img src="https://img.icons8.com/color/96/swift.png" alt="SwiftUI" width="60" title="SwiftUI"/>
  </a>
  <a href="https://developer.apple.com/mapkit/" target="_blank">
    <img src="https://img.icons8.com/color/96/google-maps.png" alt="MapKit" width="60" title="MapKit"/>
  </a>
  <a href="https://developer.apple.com/ios/" target="_blank">
    <img src="https://img.icons8.com/color/96/ios.png" alt="iOS" width="60" title="iOS 17+"/>
  </a>
  <a href="https://www.apple.com/xcode/" target="_blank">
    <img src="https://img.icons8.com/color/96/xcode.png" alt="Xcode" width="60" title="Xcode"/>
  </a>
</div>

### Backend & Services
<div style="display: flex; justify-content: center; gap: 20px; flex-wrap: wrap; margin: 20px 0;">
  <a href="https://nodejs.org/" target="_blank">
    <img src="https://img.icons8.com/color/96/nodejs.png" alt="Node.js" width="60" title="Node.js"/>
  </a>
  <a href="https://expressjs.com/" target="_blank">
    <img src="https://img.icons8.com/color/96/express-js.png" alt="Express" width="60" title="Express.js"/>
  </a>
</div>

### Architecture & Tools
<div style="display: flex; justify-content: center; gap: 20px; flex-wrap: wrap; margin: 20px 0;">
  <a href="https://www.apple.com/swift/concurrency/" target="_blank">
    <img src="https://img.icons8.com/color/96/swift.png" alt="Swift Concurrency" width="60" title="Swift Concurrency"/>
  </a>
  <a href="https://www.figma.com/" target="_blank">
    <img src="https://img.icons8.com/color/96/figma.png" alt="Design" width="60" title="UI/UX Design"/>
  </a>
  <a href="https://git-scm.com/" target="_blank">
    <img src="https://img.icons8.com/color/96/git.png" alt="Git" width="60" title="Git"/>
  </a>
  <a href="https://github.com/" target="_blank">
    <img src="https://img.icons8.com/color/96/github.png" alt="GitHub" width="60" title="GitHub"/>
  </a>
</div>

</div>

---

## Quick Overview.

| Category | Details |
|----------|---------|
| **Language** | Swift 5.9+ |
| **Framework** | SwiftUI |
| **Minimum OS** | iOS 17.0 |
| **Architecture** | MVVM + State Machine |
| **Screens** | 35+ |
| **Backend** | Node.js + Express (Optional) |
| **Maps** | MapKit + MKDirections |
| **State Management** | @StateObject, @Published, @EnvironmentObject |

---

## Get started.

### Clone the repo.

```bash
git clone https://github.com/anubhavxdev/Smart-commute-ios.git
cd Smart-commute-ios
```

### Open in Xcode.

1. Open `SmartCommute.xcodeproj`
2. Select iPhone 16 Pro simulator (or your device)
3. Press `Cmd + R`

### Log in.

Use any email and password. The app works with mock data — no backend required to explore.

Want a real backend? Start the Node.js server:

```bash
cd Backend && npm install && npm start
```

---

## What's inside.

```
SmartCommute/
├── App/                    # Entry point & routing
├── Models/                 # Data structures (Sendable)
├── ViewModels/             # MVVM state management
├── Views/                  # 35+ screens, organized by feature
│   ├── Onboarding/
│   ├── Auth/
│   ├── Dashboard/
│   ├── Map/
│   ├── Tracking/
│   ├── Menu/
│   ├── Profile/
│   ├── History/
│   ├── Receipt/
│   ├── Rating/
│   ├── Wallet/
│   ├── Payments/
│   ├── Settings/
│   ├── Theme/
│   ├── Language/
│   ├── Accessibility/
│   └── Components/         # Reusable UI elements
├── Services/               # Networking & API
└── Backend/                # Node.js + Express (optional)
```

---

## Design System.

| Element | Value |
|---------|-------|
| **Primary** | `#FAD035` — SmartCommute Yellow |
| **Accent** | `#000000` — Deep Black |
| **Cards** | 16-30px corners, soft shadow, white/light |
| **Typography** | SF Pro Display / SF Pro Text |
| **Animations** | Spring ease, scale & fade transitions |
| **Material** | Glassmorphism with `.ultraThinMaterial` |

---

## Roadmap.

### ✅ Phase 1 — Core (Complete)
- Splash & onboarding
- Authentication & OTP
- Map dashboard with live drivers
- Location search & routing
- Vehicle selection & booking
- Live tracking
- Ride rating & receipt

### ✅ Phase 2 — Extended (Complete)
- Multi-stop rides
- Scheduled rides
- Ride sharing / carpool
- Emergency SOS
- Payment methods
- Fare estimator
- Corporate dashboard
- Commute insights & analytics
- 11-language support
- Dark mode & theme customization
- Accessibility settings
- Notifications
- Help & support
- Profile & preferences

### 🚧 Phase 3 — Coming Soon
- Real-time GPS tracking (CoreLocation)
- Firebase authentication
- Payment gateway integration
- Push notifications (APNs)
- Driver companion app
- Real-time chat (WebSocket)
- Ride cancellation flow
- Surge pricing engine

---

## Contributing.

We welcome contributions. Fork the repo, create a feature branch, and send a pull request. Let's build something great together.

---

## License.

Open source under the [MIT License](LICENSE).

---

<div align="center">

**Built with 💛 and SwiftUI by [@anubhavxdev](https://github.com/anubhavxdev)**

*SmartCommute — Ride anywhere, designed in SwiftUI.*

[GitHub](https://github.com/anubhavxdev/Smart-commute-ios) • [Portfolio](https://anubhavjaiswal.me) • [Email](mailto:anubhavjaiswal1803@gmail.com)

</div>
