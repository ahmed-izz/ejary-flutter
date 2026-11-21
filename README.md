# Ejary (إيجاري) — Real Estate Rental Platform

A Flutter real estate rental application built with **Feature-First Clean Architecture**, the **Repository Pattern**, and **GetX** for state management, dependency injection, routing, localization, and theming.

## Overview

Ejary supports two distinct user roles—**Tenant** and **Landlord / Owner**—with role-adaptive navigation and workflows. All data (users, properties, rental requests, favorites, theme, and language preferences) is persisted locally using `GetStorage`, allowing the app to run offline out of the box.

## Architecture

```text
lib/
├── core/
│   ├── bindings/        # InitialBinding for permanent services & repositories
│   ├── constants/       # GetStorage keys
│   ├── localization/    # English (LTR) & Arabic (RTL) translation dictionary
│   ├── services/        # GetxService (StorageService, AuthService, ThemeService, LocaleService)
│   ├── theme/           # Light & Dark Material 3 themes
│   └── widgets/         # Reusable UI components (EjaryButton, EjaryTextField, EjaryNetworkImage)
├── routes/              # Named routes, GetPage definitions, AuthMiddleware & GuestMiddleware
└── features/
    ├── onboarding/      # Splash & Onboarding flow (GetBuilder)
    ├── auth/            # Login & Register with Tenant / Landlord role selection
    ├── shell/           # Role-adaptive bottom navigation shell
    ├── properties/      # Explore, Search & Filters (StateMixin), Details, Landlord Listings & Form
    ├── rentals/         # Rental requests, Tenant contracts, Landlord approvals (StateMixin)
    ├── favorites/       # Saved properties per user (Obx)
    └── profile/         # Account details, AR/EN toggle, Dark/Light mode, Replay Onboarding
```

## Technical Highlights

- **State Management (GetX):**
  - `StateMixin<T>` for async loading, empty, success, and error states (`ExploreController`, `MyListingsController`, `RentalsController`).
  - `Obx` / `.obs` for reactive search, filters, favorites, and settings.
  - `GetBuilder` for targeted rebuilds (`OnboardingController`, `PropertyFormController`).
- **Dependency Injection:** `InitialBinding` for core services/repositories and per-route `Bindings` for feature controllers.
- **Routing & Guards:** Named routes with `AuthMiddleware` and `GuestMiddleware`.
- **Localization & Theming:** Instant **Arabic (RTL) / English (LTR)** switching and **Dark / Light** theme persistence via `GetStorage`.

## Demo Accounts

Use the **Quick Demo Login** buttons on the Login screen or sign in with:

| Role     | Email             | Password      |
| -------- | ----------------- | ------------- |
| Tenant   | `tenant@ejary.sa` | `password123` |
| Landlord | `owner@ejary.sa`  | `password123` |

## Getting Started

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

3. **Run analyzer & tests**
   ```bash
   flutter analyze
   flutter test
   ```