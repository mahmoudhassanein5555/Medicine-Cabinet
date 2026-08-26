# Medicine Cabinet

## App Previews

| | | | |
|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/bf0825bf-3ed8-46df-ad71-b2701e1c8270" width="100%" alt="Login Screen" /> | <img src="https://github.com/user-attachments/assets/9cb3c0d1-37e3-4011-a94f-a960d177736f" width="100%" alt="Sign Up Screen" /> | <img src="https://github.com/user-attachments/assets/6acb5360-8fec-4da2-9120-5819c0a289fd" width="100%" alt="Initial Home Screen" /> | <img src="https://github.com/user-attachments/assets/a1aa7337-adf9-4e10-a5e5-13b943181eb5" width="100%" alt="Home Screen (View 1)" /> |
| <img src="https://github.com/user-attachments/assets/e3721fc8-931b-4273-a502-493c8ff8357c" width="100%" alt="Home Screen (View 2)" /> | <img src="https://github.com/user-attachments/assets/fd7c5642-0766-46fa-a8b7-47871ff1fc1b" width="100%" alt="Medicines List" /> | <img src="https://github.com/user-attachments/assets/e0454577-aff6-4516-b56d-8886def63396" width="100%" alt="Medicine Details" /> | <img src="https://github.com/user-attachments/assets/e7c9d82d-52d6-46a3-ab29-ceb33e4f774b" width="100%" alt="Scan Medicine Packaging" /> |
| <img src="https://github.com/user-attachments/assets/5deeaa63-859b-4f64-99f4-fb4e8112c5ee" width="100%" alt="Review Extracted Details (1)" /> | <img src="https://github.com/user-attachments/assets/34bd5b13-7be3-47fa-bafd-4f97b6d5514e" width="100%" alt="Review Extracted Details (2)" /> | <img src="https://github.com/user-attachments/assets/26cf0f52-b285-4e42-9048-ae1a48e09795" width="100%" alt="Expiry & Inventory Alerts" /> | <img src="https://github.com/user-attachments/assets/d9894fb2-e59d-4c08-a674-50baf88f9971" width="100%" alt="Medicine Search" /> |
| <img src="https://github.com/user-attachments/assets/a33e9823-6f36-4fe5-9cf8-0b6e2a8624af" width="100%" alt="Empty Search State" /> | <img src="https://github.com/user-attachments/assets/f148a20c-3a51-4c4d-8e13-0309584d6ec8" width="100%" alt="Household QR Code Invite" /> | <img src="https://github.com/user-attachments/assets/6ba2be4f-fe1c-4847-a995-76233b0b5970" width="100%" alt="User Profile" /> | |

---

Medicine Cabinet is a smart mobile application built with Flutter that simplifies medication and household inventory management. The application integrates Google Gemini AI vision capabilities to scan medicine packaging, automatically extract relevant drug information and expiration dates, and organize medications across multi-user household cabinets.

This application is currently developed and optimized exclusively for the Android platform.

---

## Table of Contents

- [Overview](#overview)
- [Platform Availability](#platform-availability)
- [Core Features](#core-features)
- [System Architecture](#system-architecture)
- [Technology Stack](#technology-stack)
- [Project Directory Structure](#project-directory-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Environment Configuration](#environment-configuration)
  - [Running the Application](#running-the-application)
- [Dependencies Overview](#dependencies-overview)
- [Contributing](#contributing)
- [License](#license)

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

- **Target Operating System:** Android
- **Minimum Android SDK:** Android 5.0 (API Level 21) or higher
- **Camera Hardware:** Required for live medication scanning
- **Note:** iOS and web platforms are not currently supported in the current release.

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
- Image analysis powered by Google Gemini Vision API (`gemini-3.6-flash`).
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

1. **Presentation Layer:**
   - Views and Screens (Flutter Widgets)
   - State Management using BLoC / Cubit (`flutter_bloc`)
   - Presentation models and UI state holders

2. **Domain Layer (Pure Business Logic):**
   - Entities (Core business models independent of external APIs)
   - Use Cases (Single responsibility business actions)
   - Repository Interfaces (Abstract contracts for data access)

3. **Data Layer:**
   - Data Sources (Remote APIs via Dio/Firestore, Local storage via SharedPreferences)
   - Models (DTOs with JSON / Firestore serialization)
   - Repository Implementations (Implementing Domain repository contracts)

Dependency injection is managed uniformly across all layers using `get_it` and `injectable`.

---

## Technology Stack

- **Framework:** Flutter 3.x / Dart 3.x
- **Target Platform:** Android
- **State Management:** flutter_bloc (Cubit)
- **Dependency Injection:** get_it, injectable, injectable_generator
- **Backend and Database:** Firebase Firestore, Firebase Authentication
- **Cloud AI Services:** Google Gemini Vision API (`gemini-3.6-flash`)
- **Media Storage:** Cloudinary API
- **Networking:** Dio, pretty_dio_logger, http
- **Local Storage:** shared_preferences, flutter_secure_storage
- **UI and Styling:** flutter_screenutil, curved_labeled_navigation_bar, shimmer, skeletonizer, animate_do, lottie
- **Localization:** flutter_localizations, intl, intl_utils

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
