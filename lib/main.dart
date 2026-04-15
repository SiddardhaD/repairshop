import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/logger.dart';
import 'data/models/repair_model.dart';
import 'data/models/user_model.dart';
import 'data/models/vendor_model.dart';
import 'presentation/navigation/app_router.dart';
import 'presentation/providers/repository_providers.dart';
import 'presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await _initializeHive();
  final sharedPreferences = await SharedPreferences.getInstance();

  AppLogger.info('App initialized successfully');

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const RepairTrackerApp(),
    ),
  );
}

Future<void> _initializeHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(RepairModelAdapter());
  Hive.registerAdapter(RepairStatusUpdateModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(VendorModelAdapter());

  await Hive.openBox<RepairModel>('repairs');
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<VendorModel>('vendors');

  AppLogger.info('Hive initialized successfully');
}

class RepairTrackerApp extends ConsumerWidget {
  const RepairTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
