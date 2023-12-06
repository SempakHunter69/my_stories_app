import 'package:flutter/material.dart';
import 'package:my_stories_app/screens/home_screen.dart';
import 'package:my_stories_app/screens/login_screen.dart';
import 'package:my_stories_app/screens/onboarding_screen.dart';
import 'package:my_stories_app/screens/register_screen.dart';
import 'package:my_stories_app/screens/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  bool isRegister = false;
  bool isLogIn = false;
  bool _isOnboarding = false;
  List<Page> historyStack = [];

  set isOnboarding(bool value) {
    _isOnboarding = value;
    notifyListeners();
  }

  bool get isOnboarding => _isOnboarding;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        const MaterialPage(
          child: SplashScreen(
            key: ValueKey('SplashScreen'),
          ),
        ),
        if (isOnboarding)
          MaterialPage(
            child: OnboardingScreen(
              key: const ValueKey('OnboardingScreen'),
              goLogin: () {
                isLogIn = true;
                notifyListeners();
              },
            ),
          ),
        if (isLogIn)
          MaterialPage(
            child: LoginScreen(
              key: const ValueKey('LoginScreen'),
              goRegister: () {
                isRegister = true;
                isLogIn = false;
                notifyListeners();
              },
            ),
          ),
        if (isRegister)
          MaterialPage(
            child: RegisterScreen(
              key: const ValueKey('RegisterScreen'),
              goLogin: () {
                isLogIn = true;
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
        MaterialPage(
            child: HomeScreen(
          key: const ValueKey('HomeScreen'),
        ))
      ],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        isLogIn = false;
        isRegister = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}
