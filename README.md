# Medicine Cabinet

Medicine Cabinet is a smart mobile application built with Flutter that simplifies medication and household inventory management. The application integrates Google Gemini AI vision capabilities to scan medicine packaging, automatically extract relevant drug information and expiration dates, and organize medications across multi-user household cabinets.

This application is currently developed and optimized exclusively for the Android platform.

---

## Table of Contents

- Overview
- Platform Availability
- Core Features
- System Architecture
- Technology Stack
- Project Directory Structure
- Getting Started
  - Prerequisites
  - Installation
  - Environment Configuration
  - Running the Application
- Dependencies Overview
- Contributing
- License

---

## Overview

Managing household medications, tracking expiration dates, and avoiding duplicate purchases can be challenging for families and individuals. Medicine Cabinet addresses these challenges by offering a centralized platform where users can:

- Scan medicine packages using the device camera to extract key details automatically.
- Share medicine inventories with household members via unique invitation codes.
- Monitor expiration dates and low-stock alerts to maintain family health safety.
- Track medicine dosages and assign specific medications to individual family members.
- Access their data across sessions with Firebase cloud synchronization.

---

## Platform Availability

- Target Operating System: Android
- Minimum Android SDK: Android 5.0 (API Level 21) or higher
- Camera Hardware: Required for live medication scanning
- Note: iOS and web platforms are not currently supported in the current release.

---

## Core Features

### 1. Authentication and User Management
- Secure user registration and login with Email and Password.
- Single sign-on authentication using Google Sign-In.
- Password recovery and reset mechanism.
- Persistent session caching for fast subsequent launches.
- User profile viewing and management.

### 2. Household Management and Collaboration
- Create a shared household cabinet with a unique identifier.
- Join an existing household using an invitation code.
- Manage household members with role-aware permissions.
- Assign medicines to specific household members.
- Real-time cloud synchronization of medicine cabinets among all members.

### 3. AI-Powered Medicine Scanner
- Camera and gallery integration for capturing medicine packaging.
- Automated image upload and hosting using Cloudinary.
- Image analysis powered by Google Gemini Vision API (`gemini-2.5-flash`).
- Automated extraction of:
  - Commercial / Generic Medicine Name
  - Medicine Category (e.g., Analgesic, Antibiotic, Antihistamine)
  - Pharmaceutical Form / Type (e.g., Tablet, Syrup, Capsule, Ointment)
  - Expiration Date detection and parsing
  - Generated medical description and intended therapeutic use cases

### 4. Medicine Inventory and Management
- Complete CRUD operations (Create, Read, Update, Delete) for medications.
- Quick quantity increment and decrement controls.
- Detailed medicine view including storage advice, dosage, and assigned member.
- Category-based filtering and structured listings.

### 5. Expiry and Inventory Alerts
- Dedicated inventory monitoring dashboard.
- Real-time categorization of medications:
  - Valid and safe stock
  - Expiring soon (upcoming expiry warnings)
  - Expired medications requiring safe disposal
  - Low quantity warnings for timely replenishment

### 6. Search and Filtering
- Fast real-time search across all medicines in the active household.
- Filter by name, category, and assigned member.

### 7. Multilingual and Theming
- Full localization support for Arabic (ar) and English (en).
- Automatic Right-to-Left (RTL) and Left-to-Right (LTR) layout direction switching.
- Dedicated typography: Tajawal for Arabic and Roboto for English.
- Complete Light Mode and Dark Mode support with persistent user preference.

---

## System Architecture

The project follows Clean Architecture principles combined with a Feature-First modular structure. This ensures high testability, maintainability, and separation of concerns.

Each feature module is divided into three distinct layers:

1. Presentation Layer:
   - Views and Screens (Flutter Widgets)
   - State Management using BLoC / Cubit (`flutter_bloc`)
   - Presentation models and UI state holders

2. Domain Layer (Pure Business Logic):
   - Entities (Core business models independent of external APIs)
   - Use Cases (Single responsibility business actions)
   - Repository Interfaces (Abstract contracts for data access)

3. Data Layer:
   - Data Sources (Remote APIs via Dio/Firestore, Local storage via SharedPreferences)
   - Models (DTOs with JSON / Firestore serialization)
   - Repository Implementations (Implementing Domain repository contracts)

Dependency injection is managed uniformly across all layers using `get_it` and `injectable`.

---

## Technology Stack

- Framework: Flutter 3.x / Dart 3.x
- Target Platform: Android
- State Management: flutter_bloc (Cubit)
- Dependency Injection: get_it, injectable, injectable_generator
- Backend and Database: Firebase Firestore, Firebase Authentication
- Cloud AI Services: Google Gemini Vision API (generativelanguage.googleapis.com)
- Media Storage: Cloudinary API
- Networking: Dio, pretty_dio_logger, http
- Local Storage: shared_preferences, flutter_secure_storage
- UI and Styling: flutter_screenutil, curved_labeled_navigation_bar, shimmer, skeletonizer, animate_do, lottie
- Localization: flutter_localizations, intl, intl_utils

---

## Project Directory Structure

```text
lib/
├── core/
│   ├── api/                 # API client, endpoints, and HTTP interceptors
│   ├── bloc_observer/       # Global Bloc state logging and debugging
│   ├── constants/           # Color palettes, asset paths, and storage keys
│   ├── di/                  # Service locator configuration (GetIt / Injectable)
│   ├── dialogs/             # Reusable modal dialogs, alerts, and bottom sheets
│   ├── errors/              # Exception handling and failure mappings
│   ├── failure/             # Failure models used across domain layers
│   ├── localization/        # Translation setup and locale helpers
│   ├── network/             # Network connectivity monitoring
│   ├── settings/            # App-wide theme and language state management
│   ├── theme/               # Light and Dark theme definitions, typography
│   ├── utils/               # Cloudinary service, validators, helpers
│   └── widgets/             # Shared custom UI widgets and buttons
│
├── features/
│   ├── alerts/              # Expiry monitoring and inventory warning screens
│   ├── auth/                # Login, Register, Google Sign-in, and Password Reset
│   ├── home/                # Main dashboard, statistics, and quick navigation
│   ├── household/           # Household creation, joining, and member management
│   ├── medicine/            # Medicine listings, categories, and inventory cards
│   ├── medicine_details/    # Comprehensive medicine view, edit, and deletion
│   ├── medicine_scan/       # Camera capture, Cloudinary upload, Gemini AI parser
│   ├── onboarding/          # First-time user introductory flow
│   ├── profile/             # User settings, profile edit, language/theme toggle
│   ├── search/              # Real-time medicine search and filtering
│   ├── splash_loading_capsules.dart
│   └── splash_screen.dart   # Initial routing decision engine
│
├── generated/               # Auto-generated localization code (intl)
├── l10n/                    # Translation files (intl_ar.arb, intl_en.arb)
├── firebase_options.dart    # Firebase platform configuration
└── main.dart                # Application entry point
```

---

## Getting Started

### Prerequisites

Ensure you have the following installed on your development machine:

- Flutter SDK (version 3.12.0 or higher)
- Android Studio / Android SDK (API Level 34 recommended)
- Java Development Kit (JDK 17)
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/mahmoudhassanein5555/Medicine-Cabinet.git
   cd Medicine-Cabinet
   ```

2. Install the Flutter project dependencies:
   ```bash
   flutter pub get
   ```

3. Run code generation for dependency injection and localization:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Environment Configuration

Create a `.env` file in the root directory of the project and add your API credentials:

```env
GEMINI_API_KEY=your_google_gemini_api_key_here
```

Ensure your `google-services.json` file is placed inside the `android/app/` directory for Firebase integration:

```text
android/
└── app/
    └── google-services.json
```

### Running the Application

Connect an Android physical device with USB debugging enabled or launch an Android emulator, then run:

```bash
flutter run
```

To build a release APK for Android:

```bash
flutter build apk --release
```

The generated APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## Dependencies Overview

| Package | Purpose |
|---|---|
| `flutter_bloc` | Predictable state management following the BLoC pattern |
| `get_it` & `injectable` | Compile-time and runtime Dependency Injection |
| `dio` & `http` | Robust HTTP networking and API communication |
| `firebase_core` & `cloud_firestore` | Real-time cloud database storage |
| `firebase_auth` & `google_sign_in` | User authentication and session management |
| `camera` & `image_picker` | Device camera access and gallery image selection |
| `flutter_screenutil` | Screen adaptation and responsive UI sizing |
| `shared_preferences` | Lightweight persistent local key-value storage |
| `flutter_secure_storage` | Encrypted storage for sensitive credentials |
| `curved_labeled_navigation_bar` | Animated bottom navigation bar |
| `intl` & `flutter_localizations` | Multilingual Arabic and English support |
| `flutter_dotenv` | Secure loading of environment variables |
| `skeletonizer` & `shimmer` | Modern loading states and placeholder animations |

---

## Contributing

Contributions are welcome. If you would like to contribute to the project:

1. Fork the repository.
2. Create a new feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your descriptive commit message"
   ```
4. Push the branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a Pull Request on GitHub.

---

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
