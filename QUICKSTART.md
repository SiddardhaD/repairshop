# 🚀 Quick Start Guide

## Running the App

1. **Generate code for Hive adapters**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

2. **Run the app**:
```bash
flutter run
```

3. **Login with demo credentials**:
   - Phone: `9876543210`
   - Password: `demo123`

## Features to Try

1. **Dashboard**
   - View repair statistics
   - Browse active repairs
   - Check special offers
   - Explore featured vendors

2. **Add Repair**
   - Click the floating action button
   - Fill in repair details
   - Set expected delivery date

3. **Track Repair**
   - Tap on any repair card
   - View detailed status timeline
   - Contact vendor

4. **Notifications**
   - Check notification bell icon
   - View repair updates

5. **Profile**
   - Toggle dark mode
   - Manage settings
   - Logout

## Code Structure

All screens use Clean Architecture:
- **Domain Layer**: Business logic
- **Data Layer**: Data management (Hive)
- **Presentation Layer**: UI with Riverpod

## Making Changes

1. **Add new feature**:
   - Create entity in `domain/entities/`
   - Define repository in `domain/repositories/`
   - Implement in `data/repositories/`
   - Create provider in `presentation/providers/`
   - Build UI in `presentation/screens/`

2. **Update theme**:
   - Edit `core/theme/app_colors.dart`
   - Modify `core/theme/app_theme.dart`

3. **Add new screen**:
   - Create screen in `presentation/screens/`
   - Add route in `presentation/navigation/app_router.dart`

## Tips

- Use hot reload (r) for quick changes
- Use hot restart (R) for provider changes
- Run code generation after model changes
- Check `analysis_options.yaml` for linting rules

Happy coding! 🎉
