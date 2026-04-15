import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> saveUserId(String userId) async {
    await _prefs.setString(StorageKeys.userId, userId);
  }

  Future<String?> getUserId() async {
    return _prefs.getString(StorageKeys.userId);
  }

  Future<void> saveUserName(String name) async {
    await _prefs.setString(StorageKeys.userName, name);
  }

  Future<String?> getUserName() async {
    return _prefs.getString(StorageKeys.userName);
  }

  Future<void> saveUserEmail(String email) async {
    await _prefs.setString(StorageKeys.userEmail, email);
  }

  Future<String?> getUserEmail() async {
    return _prefs.getString(StorageKeys.userEmail);
  }

  Future<void> saveThemeMode(String themeMode) async {
    await _prefs.setString(StorageKeys.themeMode, themeMode);
  }

  Future<String?> getThemeMode() async {
    return _prefs.getString(StorageKeys.themeMode);
  }

  Future<void> saveIsFirstLaunch(bool isFirstLaunch) async {
    await _prefs.setBool(StorageKeys.isFirstLaunch, isFirstLaunch);
  }

  Future<bool> getIsFirstLaunch() async {
    return _prefs.getBool(StorageKeys.isFirstLaunch) ?? true;
  }

  Future<void> clearUserData() async {
    await _prefs.remove(StorageKeys.userId);
    await _prefs.remove(StorageKeys.userName);
    await _prefs.remove(StorageKeys.userEmail);
    await _prefs.remove(StorageKeys.userToken);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
