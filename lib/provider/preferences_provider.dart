import 'package:flutter/material.dart';
import 'package:my_stories_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  PreferencesProvider({required this.preferencesHelper});

  bool isLogout = false;
  String? _token;
  bool isTokenAvailable = false;
  String? get token => _token;

  Future<String?> getToken() async {
    final prefs = await preferencesHelper.sharedPreferences;
    _token = prefs.getString(PreferencesHelper.tokenKey);
    isTokenAvailable = _token != null;
    notifyListeners();
    return _token;
  }

  void saveToken(String token) async {
    await preferencesHelper.saveToken(token);
    _token = token;
    notifyListeners();
  }

  Future<void> clearToken() async {
    await preferencesHelper.clearToken();
    _token = null;
    isLogout = true;
    isTokenAvailable = false;
    isLogout = false;
    notifyListeners();
  }
}
