import 'package:flutter/material.dart';
import 'package:my_stories_app/data/api/api_service.dart';
import 'package:my_stories_app/data/model/login_response.dart';
import 'package:my_stories_app/data/model/register_response.dart';

class UserProvider extends ChangeNotifier {
  bool isRegister = false;
  bool isLogin = false;
  String message = '';
  RegisterResponse? registerResponse;
  LoginRespose? loginRespose;

  final ApiService apiService;
  UserProvider(this.apiService);

  Future<void> registerUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      message = '';
      isRegister = true;
      notifyListeners();
      registerResponse = await apiService.registerUser(name, email, password);
      message = registerResponse?.message ?? 'Success';
      isRegister = false;
      //print(message);
      notifyListeners();
    } catch (e) {
      isRegister = false;
      message = e.toString();
      //print(message);
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      message = '';
      isLogin = true;
      notifyListeners();
      loginRespose = await apiService.loginUser(email, password);
      message = loginRespose?.message ?? 'Success';
      isLogin = false;
      notifyListeners();
    } catch (e) {
      isLogin = false;
      message = e.toString();
      notifyListeners();
    }
  }
}
