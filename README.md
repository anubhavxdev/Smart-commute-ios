<p align="center">
  <img src="https://img.icons8.com/color/96/motorcycle.png" width="80"/>
</p>

<h1 align="center">🚀 SmartCommute</h1>

<p align="center">
  <strong>A Rapido-style ride-hailing iOS application built with SwiftUI & Node.js</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9-F05138?style=for-the-badge&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/SwiftUI-4.0-0071E3?style=for-the-badge&logo=apple&logoColor=white"/>
  <img src="https://img.shields.io/badge/Node.js-Express-339933?style=for-the-badge&logo=nodedotjs&logoColor=white"/>
  <img src="https://img.shields.io/badge/Architecture-MVVM-FF6F00?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/MapKit-Integrated-34A853?style=for-the-badge&logo=googlemaps&logoColor=white"/>
</p>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/anubhavxdev/Smart-commute-ios?style=flat-square&color=yellow"/>
  <img src="https://img.shields.io/github/license/anubhavxdev/Smart-commute-ios?style=flat-square"/>
  <img src="https://img.shields.io/github/stars/anubhavxdev/Smart-commute-ios?style=flat-square&color=yellow"/>
</p>

---

## 📖 About

**SmartCommute** is a modern, full-stack ride-hailing mobile application inspired by [Rapido](https://www.rapido.bike/). It provides users with a seamless experience to book Bikes, Autos, and Cabs through a clean, map-first interface — all powered by a lightweight Node.js backend.

> Built as a production-ready prototype demonstrating real-world iOS architecture patterns, async networking, and interactive UI state management.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Authentication** | Email/password login with real-time validation and loading states |
| 🗺️ **Map-First Dashboard** | Full-screen MapKit integration as the primary interface |
| 🏍️ **Vehicle Selection** | Choose between Bike, Auto, Cab, or Parcel with fare estimates |
| 🔍 **Live Captain Search** | Animated pulsing radar simulating real-time driver matching |
| 🧑‍✈️ **Driver Assignment** | Mock captain allocation with name, rating, vehicle & OTP |
| 📞 **Quick Actions** | Call & Message buttons on the active ride screen |
| 🕒 **Recent Trips** | Horizontally scrollable trip history with fare badges |
| 🌐 **REST API Backend** | Node.js + Express server with `/login` and `/rides` endpoints |

---

## 📱 App Flow

```
┌─────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Login       │ ──► │  Map Dashboard    │ ──► │  Select Vehicle  │
│  Screen      │     │  "Where to?"      │     │  Bike/Auto/Cab   │
└─────────────┘     └──────────────────┘     └─────────────────┘
                                                       │
                                                       ▼
                    ┌──────────────────┐     ┌─────────────────┐
                    │  Ride Confirmed   │ ◄── │  Finding Captain │
                    │  OTP + Driver     │     │  Pulsing Radar   │
                    └──────────────────┘     └─────────────────┘
```

---

## 🏗️ Architecture

SmartCommute follows the **MVVM (Model-View-ViewModel)** pattern with clean separation of concerns:

```
SmartCommute/
│
├── 📁 App/
│   └── SmartCommuteApp.swift          # App entry point & navigation
│
├── 📁 Models/
│   ├── User.swift                     # User data model
│   ├── Ride.swift                     # Ride & RideStatus models
│   ├── Driver.swift                   # Captain/Driver model
│   └── LoginResponse.swift            # API response decoder
│
├── 📁 ViewModels/
│   ├── AuthViewModel.swift            # Login state & validation
│   └── DashboardViewModel.swift       # BookingState machine & ride logic
│
├── 📁 Views/
│   ├── 📁 Auth/
│   │   └── LoginView.swift            # Yellow/Black themed login
│   ├── 📁 Dashboard/
│   │   ├── DashboardView.swift        # Map-first home screen
│   │   └── BookingFlowViews.swift     # Vehicle selection, finding, active ride
│   └── 📁 Components/
│       ├── ActionCard.swift           # Reusable icon card component
│       └── SocialLoginButton.swift    # Google/Apple login button UI
│
├── 📁 Services/
│   ├── AuthService.swift              # URLSession POST /login
│   └── DashboardService.swift         # URLSession GET /rides
│
└── 📁 Backend/
    ├── server.js                      # Express API server
    └── package.json                   # Node dependencies
```

---

## 🎨 Design Language

| Element | Style |
|---|---|
| **Primary Color** | `#FAC935` — Rapido Yellow |
| **Accent Color** | `#000000` — Bold Black |
| **Cards** | White, 20px rounded corners, soft shadow |
| **Buttons** | Full-width, black background, yellow text |
| **Map** | Edge-to-edge MapKit, centered on Bangalore |
| **Animations** | Spring transitions, pulsing radar, smooth sheet morphing |

---

## 🚀 Getting Started

### Prerequisites

- **Xcode 15+** (with iOS 17 SDK)
- **Node.js** (v18+ recommended)
- **npm** (comes with Node.js)

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/anubhavxdev/Smart-commute-ios.git
cd Smart-commute-ios
```

### 2️⃣ Start the Backend

```bash
cd Backend
npm install
npm start
```

You should see:
```
Rapido-like Backend running on http://localhost:3000
```

### 3️⃣ Run the iOS App

1. Open `SmartCommute.xcodeproj` in Xcode
2. Select an iOS Simulator (e.g., iPhone 15 Pro)
3. Hit `Cmd + R` to build and run
4. Login with any email/password combination

> **Note:** The iOS simulator connects to `localhost:3000` automatically. If testing on a physical device, replace `localhost` with your Mac's local IP address in `AuthService.swift` and `DashboardService.swift`.

---

## 🔌 API Endpoints

| Method | Endpoint | Description | Body |
|---|---|---|---|
| `POST` | `/login` | Authenticate user | `{ "email": "...", "password": "..." }` |
| `GET` | `/rides` | Fetch ride history | — |

### Example Response — `POST /login`
```json
{
  "success": true,
  "user": {
    "id": "user_1234567890",
    "name": "john",
    "email": "john@example.com"
  }
}
```

### Example Response — `GET /rides`
```json
[
  {
    "id": "ride_001",
    "destination": "Koramangala 5th Block",
    "pickupLocation": "HSR Layout",
    "time": "2025-04-01T12:00:00.000Z",
    "driverName": "John Doe",
    "status": "Upcoming"
  }
]
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **iOS Frontend** | Swift, SwiftUI, MapKit |
| **Architecture** | MVVM with `@StateObject`, `@Published`, `@EnvironmentObject` |
| **Networking** | URLSession with `async/await` |
| **Navigation** | Conditional root view switching |
| **Backend** | Node.js, Express.js |
| **Middleware** | CORS, JSON body parser |

---

## 🗺️ Roadmap

- [x] Authentication (Login/Logout)
- [x] Map-first Dashboard
- [x] Vehicle Selection with Fare Estimates
- [x] Simulated Captain Matching
- [x] Active Ride Screen with OTP
- [x] REST API Backend
- [ ] Real-time GPS Tracking
- [ ] Firebase Authentication Integration
- [ ] Payment Gateway (Razorpay/Stripe)
- [ ] Push Notifications
- [ ] Ride Rating & Feedback
- [ ] Driver-side Companion App

---

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

<p align="center">
  Made with 💛 by <a href="https://github.com/anubhavxdev">@anubhavxdev</a>
</p>
