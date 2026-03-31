<p align="center">
  <img src="https://img.icons8.com/color/96/motorcycle.png" width="80"/>
</p>

<h1 align="center">🚀 SmartCommute</h1>

<p align="center">
  <strong>A production-ready, Rapido-style ride-hailing iOS application</strong>
</p>

<br/>

<p align="center">
  <img src="https://img.shields.io/badge/Built%20with-SwiftUI-0071E3?style=for-the-badge&logo=swift&logoColor=white" height="35"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9-F05138?style=for-the-badge&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/iOS-17+-000000?style=for-the-badge&logo=apple&logoColor=white"/>
  <img src="https://img.shields.io/badge/MapKit-Routing-34A853?style=for-the-badge&logo=googlemaps&logoColor=white"/>
  <img src="https://img.shields.io/badge/Architecture-MVVM-FF6F00?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Node.js-Express-339933?style=for-the-badge&logo=nodedotjs&logoColor=white"/>
</p>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/anubhavxdev/Smart-commute-ios?style=flat-square&color=yellow"/>
  <img src="https://img.shields.io/github/license/anubhavxdev/Smart-commute-ios?style=flat-square"/>
  <img src="https://img.shields.io/github/stars/anubhavxdev/Smart-commute-ios?style=flat-square&color=yellow"/>
</p>

---

## 📖 About

**SmartCommute** is a fully functional, multi-screen ride-hailing iOS prototype inspired by [Rapido](https://www.rapido.bike/). Built **entirely in SwiftUI** with a clean MVVM architecture, it delivers a complete end-to-end booking experience — from animated splash screen to live route mapping, dynamic fare calculation, driver assignment, and post-ride rating.

> 🎯 Designed as a **production-quality prototype** showcasing modern iOS development with SwiftUI, MapKit, async/await networking, and state-driven UI.

---

## ⚡ Built Entirely with SwiftUI

This project leverages the full power of Apple's **SwiftUI** framework:

| SwiftUI Feature | Usage |
|---|---|
| `@StateObject` / `@Published` | Reactive state management across all ViewModels |
| `@EnvironmentObject` | Global auth state shared across the entire app |
| `NavigationStack` / `NavigationDestination` | Programmatic navigation between 10+ screens |
| `.animation()` / `.transition()` | Spring animations, scale transitions, slide-in menus |
| `Map` / `MKMapView` (UIViewRepresentable) | Full MapKit integration with route polylines & custom pins |
| `@FocusState` | Keyboard management in location search |
| `LazyVStack` | Performant scrolling lists with lazy loading |
| `Sheet` / `ZStack` overlays | Modal presentations & overlay-driven booking flow |
| `.ultraThinMaterial` | Glassmorphism effects on floating UI elements |
| `Timer` + `withAnimation` | Simulated real-time driver movement on map |

---

## ✨ Features

### 🔐 Authentication
- Email/password login with real-time validation
- Loading states & error handling
- Mock fallback when backend is offline

### 🗺️ Map-First Dashboard
- Full-screen interactive MapKit as the primary interface
- **10 nearby drivers** rendered as custom colored pins (🟢 Bike, 🟠 Auto, 🔵 Cab)
- Live count badge: "10 rides nearby"
- Glassmorphism floating controls
- Time-based greeting (Good morning / afternoon / evening 👋)

### 📍 Location Search & Route Planning
- Full-screen search with pickup & destination fields
- **10 predefined Bangalore locations** with real GPS coordinates
- Saved Places (Home, Office) for quick access
- Real-time search filtering
- **MKDirections route polyline** drawn on the map between pickup and drop
- Custom map annotations: 🟢 Pickup pin, 🔴 Drop pin with checkered flag

### 💰 Dynamic Fare Calculation
- Fares calculated based on **actual distance** between coordinates
- Per-km rates: Bike ₹12/km, Auto ₹18/km, Cab ₹35/km
- Route preview sheet with distance, ETA, and fare comparison chips
- Detailed fare breakdown with GST

### 🏍️ Vehicle Selection
- Choose between **Bike**, **Auto**, **Cab**, or **Parcel**
- Each shows estimated fare & ETA based on distance
- Highlighted selection with yellow accent border

### 🔍 Captain Matching
- Animated pulsing radar effect simulating real-time driver search
- 3-second simulated matching algorithm
- Cancel search option

### 🧑‍✈️ Active Ride & Driver Tracking
- Assigned captain with **randomized** name, rating, vehicle, plate number
- **4-digit OTP** generated for ride verification
- **Driver icon moves toward you on the map** every 2 seconds
- Call & Message action buttons
- End Ride button

### ⭐ Post-Ride Rating
- Interactive 5-star rating with tap animation
- Optional text feedback
- Tip selection (₹10 / ₹20 / ₹50) with toggle
- Skip option

### 📋 Side Menu
- Slide-in hamburger menu with profile header
- Navigation to: My Rides, Wallet, Offers, Settings
- User avatar, rating, phone number display
- Logout with auth state reset

### 🕓 Ride History
- **9 past rides** with real Bangalore destinations
- Summary stats bar: Total Rides, Total Spent, Avg Rating
- **Filter chips**: All / Bike / Auto / Cab
- Inline star rating display
- Tap any ride → detailed receipt view

### 🧾 Ride Detail / Receipt
- Pickup → Drop route with dot trail
- Trip stats: Distance, Duration, Fare
- Complete fare breakdown with platform fee & GST
- Driver info with vehicle type badge & plate number
- Payment method display
- Invoice & Report buttons

### 💰 Wallet
- Animated balance card on yellow gradient
- Quick add money buttons (+₹100, +₹200, +₹500) — **actually updates balance**
- 6 transaction entries (rides, cashback, referral bonus)
- Color-coded credit (green) / debit (red) with icons

### 🎁 Offers & Coupons
- 4 vibrant gradient coupon cards (purple, blue, orange, green)
- Promo codes with "Apply" → "Copied!" feedback
- Promotional text with discount percentages

### ⚙️ Settings
- Profile section with Edit button
- Toggle switches: Notifications, Location Services
- Saved Places: Home & Office with addresses
- Add New Place option
- Privacy Policy, Terms of Service, Help links
- Logout button & app version footer

### 🎬 Splash Screen
- Animated bicycle icon with spring bounce effect
- SmartCommute branding with tagline
- 2-second auto-transition to main app

---

## 📱 Complete User Flow

```
┌──────────┐    ┌──────────┐    ┌───────────────┐    ┌──────────────┐
│  Splash   │──▶│  Login    │──▶│   Dashboard    │──▶│ Location     │
│  Screen   │   │  Screen   │   │   (Map View)   │   │ Search       │
└──────────┘    └──────────┘    └───────────────┘    └──────┬───────┘
                                       │                     │
                                  ┌────┴────┐               ▼
                                  │ Side    │    ┌──────────────────┐
                                  │ Menu    │    │  Route Preview   │
                                  └────┬────┘    │  (Map + Fares)   │
                               ┌──────┤          └────────┬─────────┘
                               │      │                   │
                          ┌────▼──┐ ┌─▼────┐     ┌───────▼────────┐
                          │ Rides │ │Wallet│     │Vehicle Select  │
                          │History│ │      │     │ Bike/Auto/Cab  │
                          └───────┘ └──────┘     └───────┬────────┘
                                                         │
                          ┌────────┐            ┌────────▼────────┐
                          │Settings│            │ Finding Captain  │
                          └────────┘            │ (Pulsing Radar)  │
                                                └────────┬────────┘
                          ┌────────┐            ┌────────▼────────┐
                          │ Offers │            │  Ride Confirmed  │
                          └────────┘            │  (Driver + OTP)  │
                                                └────────┬────────┘
                                                         │
                                                ┌────────▼────────┐
                                                │  Rating Screen   │
                                                │  ⭐⭐⭐⭐⭐ + Tip │
                                                └─────────────────┘
```

---

## 🏗️ Architecture

SmartCommute follows **MVVM (Model-View-ViewModel)** with clean separation of concerns:

```
SmartCommute/
│
├── 📁 App/
│   ├── SmartCommuteApp.swift              # @main entry point
│   └── ContentRouterView.swift            # Auth state router
│
├── 📁 Models/
│   ├── User.swift                         # User model (Sendable)
│   ├── Ride.swift                         # Ride & RideStatus
│   ├── Driver.swift                       # Captain model + VehicleType
│   └── LoginResponse.swift               # API response decoder
│
├── 📁 ViewModels/
│   ├── AuthViewModel.swift                # Login state & validation
│   └── DashboardViewModel.swift           # BookingState machine, fares, routing
│
├── 📁 Views/
│   ├── 📁 Splash/
│   │   └── SplashView.swift               # Animated launch screen
│   ├── 📁 Auth/
│   │   └── LoginView.swift                # Yellow/Black themed login
│   ├── 📁 Dashboard/
│   │   ├── DashboardView.swift            # Map-first home + state switching
│   │   └── BookingFlowViews.swift         # Vehicle select, finding, active ride
│   ├── 📁 Map/
│   │   ├── RouteMapView.swift             # UIViewRepresentable MKMapView
│   │   └── LocationSearchView.swift       # Pickup & destination search
│   ├── 📁 Menu/
│   │   └── SideMenuView.swift             # Slide-in navigation drawer
│   ├── 📁 History/
│   │   ├── RideHistoryView.swift          # Past rides + filters + stats
│   │   └── RideDetailView.swift           # Trip receipt & breakdown
│   ├── 📁 Rating/
│   │   └── RatingView.swift               # Stars + tips + feedback
│   ├── 📁 Wallet/
│   │   └── WalletView.swift               # Balance + transactions
│   ├── 📁 Offers/
│   │   └── OffersView.swift               # Gradient coupon cards
│   ├── 📁 Settings/
│   │   └── SettingsView.swift             # Toggles + saved places
│   └── 📁 Components/
│       ├── ActionCard.swift               # Reusable vehicle card
│       └── SocialLoginButton.swift        # Google/Apple login UI
│
├── 📁 Services/
│   ├── AuthService.swift                  # URLSession + mock fallback
│   └── DashboardService.swift             # Rides API + mock fallback
│
├── 📁 Resources/
│   └── Assets.xcassets/                   # App icons & colors
│
└── 📁 Backend/
    ├── server.js                          # Express REST API
    └── package.json                       # Node dependencies
```

---

## 🎨 Design System

| Element | Style |
|---|---|
| **Primary** | `#FAC935` — Rapido Yellow |
| **Accent** | `#000000` — Bold Black |
| **Cards** | White, 16-30px rounded, soft shadow |
| **Buttons** | Full-width, yellow bg, black text |
| **Map** | Edge-to-edge, MKDirections route polyline |
| **Pins** | Custom rendered circles with SF Symbols |
| **Material** | `.ultraThinMaterial` glassmorphism |
| **Animations** | Spring transitions, pulsing radar, scale effects |

---

## 🚀 Getting Started

### Prerequisites
- **Xcode 15+** (iOS 17 SDK)
- **Node.js v18+** *(optional — app works offline with mock data)*

### 1️⃣ Clone

```bash
git clone https://github.com/anubhavxdev/Smart-commute-ios.git
cd Smart-commute-ios
```

### 2️⃣ Run iOS App

1. Open `SmartCommute.xcodeproj` in Xcode
2. Select iPhone 16 Pro simulator
3. Press `Cmd + R`
4. Login with **any email/password**

### 3️⃣ Run Backend *(Optional)*

```bash
cd Backend && npm install && npm start
# Server runs on http://localhost:3000
```

> The app automatically falls back to mock data if the backend is not running.

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/login` | Authenticate user |
| `GET` | `/rides` | Fetch ride history |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **UI Framework** | **SwiftUI** (100% declarative UI) |
| **Maps** | MapKit, MKDirections, MKPolyline, UIViewRepresentable |
| **Architecture** | MVVM + State Machine (BookingState enum) |
| **State** | `@StateObject`, `@Published`, `@EnvironmentObject` |
| **Networking** | URLSession with `async/await` |
| **Backend** | Node.js + Express.js |
| **Concurrency** | Swift Concurrency (Sendable, nonisolated) |

---

## 🗺️ Roadmap

- [x] Animated Splash Screen
- [x] Authentication (Login/Logout)
- [x] Map-First Dashboard with nearby drivers
- [x] Full Location Search (Pickup + Destination)
- [x] MKDirections Route Polyline
- [x] Distance-Based Dynamic Fares
- [x] Vehicle Selection (Bike/Auto/Cab)
- [x] Captain Matching Animation
- [x] Active Ride with Driver Movement
- [x] OTP Verification Display
- [x] Post-Ride Rating + Tips
- [x] Side Menu Navigation
- [x] Ride History with Filters
- [x] Trip Detail / Receipt
- [x] Wallet with Transactions
- [x] Offers & Coupon Cards
- [x] Settings & Saved Places
- [ ] Real-time GPS Tracking (CoreLocation)
- [ ] Firebase Authentication
- [ ] Payment Gateway (Razorpay/Stripe)
- [ ] Push Notifications
- [ ] Driver-side Companion App

---

## 🤝 Contributing

Contributions welcome! Fork → Feature Branch → Pull Request.

---

## 📄 License

Open source under the [MIT License](LICENSE).

---

<p align="center">
  Built with 💛 and <b>SwiftUI</b> by <a href="https://github.com/anubhavxdev">@anubhavxdev</a>
</p>
