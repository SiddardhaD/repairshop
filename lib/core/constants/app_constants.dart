class AppConstants {
  static const String appName = 'Repair Tracker';
  static const String appVersion = '1.0.0';
  
  static const int maxImageSize = 5 * 1024 * 1024;
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceDelay = Duration(milliseconds: 500);
  
  static const double borderRadius = 16.0;
  static const double cardElevation = 2.0;
  static const double maxContentWidth = 600.0;
  
  static const int notificationMaxLines = 3;
  static const int repairHistoryPageSize = 20;
}

class StorageKeys {
  static const String userToken = 'user_token';
  static const String userId = 'user_id';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String themeMode = 'theme_mode';
  static const String isFirstLaunch = 'is_first_launch';
}

class RouteNames {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String repairDetails = '/repair-details';
  static const String addRepair = '/add-repair';
  static const String vendorDetails = '/vendor-details';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
}
