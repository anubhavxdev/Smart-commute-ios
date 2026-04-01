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
  <img src="https://img.shields.io/badge/Screens-35+-FAD035?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Node.js-Express-339933?style=for-the-badge&logo=nodedotjs&logoColor=white"/>
</p>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/anubhavxdev/Smart-commute-ios?style=flat-square&color=yellow"/>
  <img src="https://img.shields.io/github/license/anubhavxdev/Smart-commute-ios?style=flat-square"/>
  <img src="https://img.shields.io/github/stars/anubhavxdev/Smart-commute-ios?style=flat-square&color=yellow"/>
</p>

---

## 📖 About

**SmartCommute** is a fully functional, **35+ screen** ride-hailing iOS application inspired by [Rapido](https://www.rapido.bike/). Built **entirely in SwiftUI** with clean MVVM architecture, it delivers a comprehensive end-to-end commuting experience — from onboarding and authentication to ride booking, live tracking, payments, corporate dashboards, and ride analytics.

> 🎯 Designed as a **production-quality prototype** showcasing modern iOS development with SwiftUI, MapKit, async/await networking, and state-driven UI.

---

## ⚡ Built Entirely with SwiftUI

This project leverages the full power of Apple's **SwiftUI** framework:

| SwiftUI Feature | Usage |
|---|---|
| `@StateObject` / `@Published` | Reactive state management across all ViewModels |
| `@EnvironmentObject` | Global auth state shared across the entire app |
| `NavigationStack` / `NavigationDestination` | Programmatic navigation between 35+ screens |
| `.animation()` / `.transition()` | Spring animations, scale transitions, slide-in menus |
| `Map` / `MKMapView` (UIViewRepresentable) | Full MapKit integration with route polylines & custom pins |
| `@FocusState` | Keyboard management in location search |
| `LazyVStack` / `LazyVGrid` | Performant scrolling lists with lazy loading |
| `Sheet` / `ZStack` overlays | Modal presentations & overlay-driven booking flow |
| `.ultraThinMaterial` | Glassmorphism effects on floating UI elements |
| `Timer` + `withAnimation` | Simulated real-time driver movement on map |
| `GeometryReader` | Responsive route visualization & animated charts |
| `TabView(.page)` | Onboarding carousel with custom page indicators |

---

## ✨ Features

### 🎬 Onboarding & Authentication
- **4-page animated onboarding** with gradient backgrounds and page indicators
- Email/password login with real-time validation
- **OTP verification** with 6-digit auto-advancing input and countdown timer
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

### 🏍️ Vehicle Selection & Booking
- Choose between **Bike**, **Auto**, **Cab**, or **Parcel**
- Animated pulsing radar for captain matching
- Assigned captain with randomized name, rating, vehicle, plate number
- **4-digit OTP** generated for ride verification

### 📡 Live Ride Tracking *(NEW)*
- Real-time animated route visualization with bezier curves
- **Driver icon moves along the route** with pulsing animation
- ETA countdown and progress percentage
- Integrated SOS button, Call, Chat, and Share actions

### 🛣️ Multi-Stop Rides *(NEW)*
- Add up to 3 intermediate stops with timeline visualization
- Dynamic stop management (add/remove)
- Quick-add suggested locations
- Per-stop fare estimation with wait time display

### 📅 Scheduled Rides *(NEW)*
- Advance ride scheduling with date/time pickers
- Recurring weekday toggle for daily commutes
- Upcoming scheduled rides management

### 🤝 Ride Sharing / Carpool *(NEW)*
- Colleague matching with route compatibility
- CO₂ savings tracking and environmental impact
- Active pool management and creation

### ⭐ Post-Ride Experience
- Interactive 5-star rating with tap animation
- Optional text feedback & tip selection (₹10/₹20/₹50)
- **Detailed ride receipt** with fare breakdown, PDF download, and sharing

### 🔐 Safety & Emergency *(NEW)*
- **Emergency SOS** with animated panic button
- Emergency contact management
- Safety feature toggles (share ride, trusted contacts)
- Quick-action safety tips

### 💳 Payments & Wallet *(NEW)*
- **Multiple payment methods**: UPI, Cards, Wallet, Corporate Billing
- Default payment selection
- Animated wallet balance card
- Transaction history with color-coded credits/debits

### 🧮 Fare Estimator *(NEW)*
- Route-based fare calculation across vehicle types
- Popular route suggestions
- Fare range display for Bike, Auto, and Cab

### 🏢 Corporate Features *(NEW)*
- **Corporate Dashboard** with budget ring chart
- Company policy rules and ride limits
- Team activity leaderboard
- Expense report generation

### 📊 Commute Insights *(NEW)*
- Weekly spending analytics with bar charts
- Vehicle usage breakdown (Bike / Auto / Cab percentage)
- Top routes analysis
- Environmental impact stats (CO₂ saved, trees equivalent)

### 🎁 Referral Program *(NEW)*
- Invite-and-earn system with shareable referral code
- How-it-works step guide
- Referral tracking with status indicators
- Earnings dashboard

### ❤️ Favorite Drivers *(NEW)*
- Driver management with heart toggle
- Vehicle info and rating display
- Preference toggles for priority assignment

### 📋 Side Menu & Navigation
- **Organized side menu** with section labels (Commute Tools, Corporate & Insights, More)
- 20+ navigation destinations
- Profile header with avatar and rating
- Quick access to all features

### 🔔 Notifications *(NEW)*
- Categorized inbox (Rides, Promos, System)
- Read/unread badges with mark-all-read
- Filter by notification type

### ❓ Help & Support *(NEW)*
- Searchable FAQ
- Quick action cards (chat, call, email, ticket)
- Recent ride issue reporting

### 📍 Saved Addresses *(NEW)*
- Address management with custom icon picker
- Quick-access pills for Home, Office, Gym
- Add/edit/delete addresses

### 🎨 Customization *(NEW)*
- **Theme settings** with System/Light/Dark mode
- Accent color picker with live preview
- **Language selection** with 11 Indian languages
- Translation completion indicators
- **Accessibility settings** with font slider, high contrast, wheelchair access, quick presets

### ℹ️ About & Legal *(NEW)*
- Company mission and stats
- Terms of Service & Privacy Policy (embedded sheets)
- Social media links
- App version info

### 👤 Profile *(NEW)*
- Editable profile with avatar
- Personal info management
- Emergency contact setup
- Ride preferences (vehicle, music, AC)

---

## 📱 Complete User Flow

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌───────────────┐
│ Onboarding│──▶│  Login    │──▶│   OTP    │──▶│  Splash   │──▶│   Dashboard    │
│ (4 pages) │   │  Screen   │   │  Verify  │   │  Screen   │   │   (Map View)   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └───────┬───────┘
                                                                        │
                    ┌───────────────────────────────────────────────────┤
                    │                                                   │
               ┌────▼────┐                                    ┌────────▼────────┐
               │ Side    │                                    │ Location Search  │
               │ Menu    │                                    └────────┬────────┘
               └────┬────┘                                             │
      ┌─────────────┼──────────────┐                         ┌────────▼────────┐
      │             │              │                         │  Route Preview   │
┌─────▼─────┐ ┌────▼────┐  ┌─────▼─────┐                   └────────┬────────┘
│  Profile  │ │  Rides  │  │  Wallet   │                            │
│  Editor   │ │ History │  │ & Payments│                   ┌────────▼────────┐
└───────────┘ └────┬────┘  └───────────┘                   │ Vehicle Select  │
                   │                                        └────────┬────────┘
              ┌────▼────┐                                            │
              │  Ride   │                                   ┌────────▼────────┐
              │ Receipt │                                   │ Captain Matching │
              └─────────┘                                   └────────┬────────┘
                                                                     │
┌───────────────────┐  ┌──────────────┐                    ┌────────▼────────┐
│ Commute Tools     │  │ Corporate    │                    │  Live Tracking   │
├───────────────────┤  ├──────────────┤                    │  (Real-time)     │
│ Schedule Ride     │  │ Dashboard    │                    └────────┬────────┘
│ Multi-Stop        │  │ Insights     │                             │
│ Ride Sharing      │  │ Referrals    │                    ┌────────▼────────┐
│ Fare Estimator    │  └──────────────┘                    │  Rating + Tip    │
│ Saved Addresses   │                                      └─────────────────┘
│ Favorite Drivers  │
└───────────────────┘

┌───────────────────┐
│ Settings & More   │
├───────────────────┤
│ Theme / Dark Mode │
│ Language (11)     │
│ Accessibility     │
│ Notifications     │
│ Emergency SOS     │
│ Help & Support    │
│ About / Legal     │
└───────────────────┘
```

---

## 🏗️ Architecture

SmartCommute follows **MVVM (Model-View-ViewModel)** with clean separation of concerns:

```
SmartCommute/
│
├── 📁 App/
│   ├── SmartCommuteApp.swift              # @main entry point
│   └── ContentRouterView.swift            # Auth + Onboarding router
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
│   ├── 📁 Onboarding/
│   │   └── OnboardingView.swift           # 4-page walkthrough carousel
│   ├── 📁 Splash/
│   │   └── SplashView.swift               # Animated launch screen
│   ├── 📁 Auth/
│   │   ├── LoginView.swift                # Yellow/Black themed login
│   │   └── OTPVerificationView.swift      # 6-digit OTP with auto-advance
│   ├── 📁 Dashboard/
│   │   ├── DashboardView.swift            # Map-first home + state switching
│   │   └── BookingFlowViews.swift         # Vehicle select, finding, active ride
│   ├── 📁 Map/
│   │   ├── RouteMapView.swift             # UIViewRepresentable MKMapView
│   │   └── LocationSearchView.swift       # Pickup & destination search
│   ├── 📁 Tracking/
│   │   └── LiveTrackingView.swift         # Real-time driver tracking + SOS
│   ├── 📁 Menu/
│   │   └── SideMenuView.swift             # Slide-in navigation (20+ items)
│   ├── 📁 Profile/
│   │   └── ProfileView.swift              # Editable profile & preferences
│   ├── 📁 History/
│   │   ├── RideHistoryView.swift          # Past rides + filters + stats
│   │   └── RideDetailView.swift           # Trip receipt & breakdown
│   ├── 📁 Receipt/
│   │   └── RideReceiptView.swift          # Detailed invoice + share/download
│   ├── 📁 Rating/
│   │   └── RatingView.swift               # Stars + tips + feedback
│   ├── 📁 Wallet/
│   │   └── WalletView.swift               # Balance + transactions
│   ├── 📁 Payments/
│   │   └── PaymentMethodsView.swift       # UPI, Cards, Corporate billing
│   ├── 📁 Offers/
│   │   └── OffersView.swift               # Gradient coupon cards
│   ├── 📁 Schedule/
│   │   └── ScheduleRideView.swift         # Advance booking + recurring rides
│   ├── 📁 MultiStop/
│   │   └── MultiStopRideView.swift        # Dynamic multi-stop management
│   ├── 📁 Carpool/
│   │   └── RideSharingView.swift          # Carpool matching + CO₂ tracking
│   ├── 📁 FareEstimator/
│   │   └── FareEstimatorView.swift        # Route-based fare calculator
│   ├── 📁 SavedAddresses/
│   │   └── SavedAddressesView.swift       # Address management + icon picker
│   ├── 📁 FavoriteDrivers/
│   │   └── FavoriteDriversView.swift      # Driver preferences + priority
│   ├── 📁 Corporate/
│   │   └── CorporateDashboardView.swift   # Budget tracking + team activity
│   ├── 📁 Insights/
│   │   └── CommuteInsightsView.swift      # Analytics + spending charts
│   ├── 📁 Referral/
│   │   └── ReferralView.swift             # Invite & earn program
│   ├── 📁 Notifications/
│   │   └── NotificationsView.swift        # Categorized notification inbox
│   ├── 📁 Emergency/
│   │   └── EmergencySOSView.swift         # Panic button + contacts
│   ├── 📁 Support/
│   │   └── HelpSupportView.swift          # FAQ + quick action support
│   ├── 📁 About/
│   │   └── AboutView.swift                # Company info + legal docs
│   ├── 📁 Settings/
│   │   └── SettingsView.swift             # Comprehensive settings hub
│   ├── 📁 Theme/
│   │   └── ThemeSettingsView.swift         # Dark mode + accent color picker
│   ├── 📁 Language/
│   │   └── LanguageSelectionView.swift     # 11 Indian languages
│   ├── 📁 Accessibility/
│   │   └── AccessibilitySettingsView.swift # Font size, contrast, presets
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
| **Primary** | `#FAD035` — SmartCommute Yellow |
| **Accent** | `#000000` — Bold Black |
| **Cards** | White, 16-30px rounded, soft shadow |
| **Buttons** | Full-width, yellow bg, black text |
| **Map** | Edge-to-edge, MKDirections route polyline |
| **Pins** | Custom rendered circles with SF Symbols |
| **Material** | `.ultraThinMaterial` glassmorphism |
| **Animations** | Spring transitions, pulsing radar, scale effects |
| **Charts** | Custom `GeometryReader` bar charts & ring charts |

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
4. Swipe through onboarding → Login with **any email/password**

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

### ✅ Completed (Phase 1 — Core)
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

### ✅ Completed (Phase 2 — 22 New Screens)
- [x] Onboarding Walkthrough (4 pages)
- [x] OTP Verification Screen
- [x] Profile / Edit Profile
- [x] Live Ride Tracking
- [x] Multi-Stop Rides
- [x] Scheduled Rides
- [x] Ride Sharing / Carpool
- [x] Detailed Ride Receipt
- [x] Emergency SOS
- [x] Payment Methods
- [x] Fare Estimator
- [x] Saved Addresses Management
- [x] Favorite Drivers
- [x] Corporate Dashboard
- [x] Commute Insights & Analytics
- [x] Referral Program
- [x] Notifications Inbox
- [x] Help & Support
- [x] About / Legal
- [x] Theme / Dark Mode Toggle
- [x] Language Selection (11 languages)
- [x] Accessibility Settings

### 🚧 Future (Phase 3)
- [ ] Real-time GPS Tracking (CoreLocation)
- [ ] Firebase Authentication
- [ ] Payment Gateway (Razorpay/Stripe)
- [ ] Push Notifications (APNs)
- [ ] Driver-side Companion App
- [ ] Real-time Chat (WebSocket)
- [ ] Ride Cancellation Flow
- [ ] Surge Pricing Engine

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
