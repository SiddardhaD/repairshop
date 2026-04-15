# 🔧 Repair Tracker

A production-ready Flutter mobile application for tracking repair items with Clean Architecture and Riverpod state management.

## 📱 Overview

Repair Tracker is a comprehensive mobile application that allows users to track the status of their repair items (mobile phones, appliances, electronics, etc.) similar to order tracking in e-commerce apps like Flipkart.

## ✨ Features

### 🔐 Authentication
- Login/Signup with form validation
- Mock OTP verification support
- Session persistence
- Secure logout

### 🏠 Dashboard
- **Modern UI with Stats Cards**
  - Active Repairs
  - In Progress
  - Completed
  - Out for Delivery

- **Active Repairs List**
  - Product name and icon
  - Current status with badges
  - Progress indicator
  - Expected delivery date
  - Vendor information
  - Quick actions (Call vendor, Track status)

- **Special Offers Section**
  - Promotional banners
  - Discount badges
  - Horizontal scrolling carousel

- **Featured Vendors**
  - Vendor ratings and reviews
  - Distance information
  - Quick booking options

### 🔧 Repair Management
- **Add New Repair**
  - Product details form
  - Issue description
  - Vendor selection
  - Expected delivery date picker
  - Cost estimation
  - Optional notes

- **Repair Details Screen**
  - Complete repair timeline (Flipkart-style)
  - Step-by-step status tracking
  - Vendor contact information
  - Issue description
  - Cost breakdown
  - Progress visualization

### 🔔 Notifications
- Real-time status updates
- Delivery notifications
- Payment reminders
- Promotional offers
- Mark as read functionality

### 👤 Profile & Settings
- User profile management
- Dark mode toggle
- Notification preferences
- Language settings
- Help & support
- Privacy policy
- App version info

## 🏗️ Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/
│   ├── constants/       # App-wide constants
│   ├── theme/           # Theme configuration (light/dark)
│   └── utils/           # Helper functions, extensions, validators
│
├── domain/              # Business Logic Layer
│   ├── entities/        # Core business models
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business use cases
│
├── data/                # Data Layer
│   ├── models/          # Data models (DTOs) with Hive
│   ├── repositories/    # Repository implementations
│   └── services/        # Data services (API, local storage, mock)
│
└── presentation/        # Presentation Layer
    ├── navigation/      # Routing configuration (GoRouter)
    ├── providers/       # Riverpod state management
    ├── screens/         # UI screens
    └── widgets/         # Reusable widgets
```

## 🎨 Tech Stack

### Core
- **Flutter SDK**: ^3.9.2
- **Dart**: Null safety enabled

### State Management
- **flutter_riverpod**: ^2.6.1
- **riverpod_annotation**: ^2.6.1

### Local Storage
- **hive**: ^2.2.3
- **hive_flutter**: ^1.1.0
- **shared_preferences**: ^2.3.3

### Navigation
- **go_router**: ^14.6.2

### Code Generation
- **freezed**: ^2.5.7
- **json_serializable**: ^6.8.0
- **build_runner**: ^2.4.13

### Utilities
- **intl**: ^0.19.0 (Date formatting)
- **uuid**: ^4.5.1 (ID generation)
- **logger**: ^2.5.0 (Logging)
- **equatable**: ^2.0.5 (Value equality)

### UI Enhancement
- **shimmer**: ^3.0.0 (Loading states)
- **flutter_animate**: ^4.5.0 (Animations)
- **cached_network_image**: ^3.4.1 (Image caching)
- **flutter_svg**: ^2.0.10+1 (SVG support)

### Other
- **url_launcher**: ^6.3.1 (External links)
- **image_picker**: ^1.1.2 (Image selection)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart 3.0 or higher
- iOS 12.0+ / Android API 21+

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd repairtracker
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run code generation**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

## 📦 Project Structure Details

### Core Layer
- **Constants**: App-wide configuration values
- **Theme**: Material Design 3 with light/dark mode support
- **Utils**: 
  - Extensions (DateTime, String, Double)
  - Validators (Email, Phone, Password)
  - Helpers (SnackBar, Dialogs)
  - Logger (Development logging)

### Domain Layer
- **Entities**: Pure Dart classes representing core business objects
  - Repair (with status tracking)
  - User
  - Vendor
  - Notification
  - Promotion

- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Single-responsibility business logic classes

### Data Layer
- **Models**: Hive-annotated models for local storage
- **Repository Implementations**: Concrete implementations using Hive
- **Services**:
  - LocalStorageService (SharedPreferences wrapper)
  - MockDataService (Mock data for development)

### Presentation Layer
- **Providers**: Riverpod providers for state management
  - AuthProvider
  - RepairProvider
  - VendorProvider
  - ThemeProvider

- **Screens**: Feature-based organization
  - Auth (Login, Signup)
  - Dashboard
  - Repair (Details, Add)
  - Notifications
  - Profile

- **Widgets**: Reusable UI components
  - CustomButton
  - CustomTextField
  - StatusBadge
  - StatCard
  - EmptyState
  - LoadingShimmer
  - ErrorView

## 🎨 Design Features

### Modern UI/UX
- Material Design 3
- Rounded corners (16px radius)
- Smooth animations and transitions
- Consistent spacing system
- Typography hierarchy

### Dark Mode
- Automatic theme switching
- Optimized colors for both modes
- Proper contrast ratios

### Responsive Design
- Adaptive layouts
- Mobile-first approach
- Tablet support ready

### Loading States
- Shimmer effects
- Progress indicators
- Skeleton screens

### Error Handling
- User-friendly error messages
- Retry mechanisms
- Graceful degradation

## 🧪 Demo Credentials

For testing the app:
- **Phone**: 9876543210
- **Password**: demo123

## 📝 Key Features Implementation

### Status Tracking
The repair tracking system mimics popular e-commerce platforms:
1. Received
2. Diagnosing
3. Waiting for Parts
4. Repairing
5. Completed
6. Out for Delivery
7. Delivered

Each status has:
- Visual indicator
- Progress percentage
- Timestamp
- Optional notes

### Repository Pattern
All data access goes through repository interfaces, making it easy to:
- Switch data sources (local to API)
- Test business logic
- Mock data for development

### State Management with Riverpod
- Type-safe providers
- Automatic disposal
- Easy testing
- No BuildContext needed for business logic

## 🔄 Future Enhancements

- [ ] Backend API integration
- [ ] Image upload for repairs
- [ ] Real-time notifications (Firebase)
- [ ] Payment integration
- [ ] Map view for vendor location
- [ ] OTP-based login
- [ ] Multi-language support
- [ ] Review & rating system
- [ ] Search & filter repairs
- [ ] Export repair history (PDF)

## 🐛 Known Issues

- Mock data is currently used for vendors and promotions
- Image upload is not yet implemented
- OTP verification is mock (always accepts 123456)

## 🤝 Contributing

This is a production-ready template. Feel free to:
1. Fork the repository
2. Create feature branches
3. Add backend integration
4. Enhance UI/UX
5. Add more features

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

Built with ❤️ using Flutter and Clean Architecture principles.

## 📞 Support

For issues, questions, or suggestions, please open an issue in the repository.

---

**Note**: This is a demonstration app showcasing Clean Architecture and best practices in Flutter development. For production use, integrate with a real backend API and add proper authentication.
# repairshop
