import 'package:flutter/material.dart';
import 'package:my_stories_app/data/model/stories_response.dart';
import 'package:my_stories_app/data/preferences/preferences_helper.dart';
import 'package:my_stories_app/screens/detail_screen.dart';
import 'package:my_stories_app/screens/home_screen.dart';
import 'package:my_stories_app/screens/login_screen.dart';
import 'package:my_stories_app/screens/onboarding_screen.dart';
import 'package:my_stories_app/screens/register_screen.dart';
import 'package:my_stories_app/screens/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final PreferencesHelper preferencesHelper;

  MyRouterDelegate(this.preferencesHelper)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLogIn = await preferencesHelper.haveToken();
    notifyListeners();
  }

  bool isRegister = false;
  bool? isLogIn = false;
  bool _isOnboarding = false;
  bool isHome = false;
  List<Page> historyStack = [];
  Story? selectedStory;

  List<Page> get _splashStack => [
        const MaterialPage(
            child: SplashScreen(
          key: ValueKey('SplashScreen'),
        ))
      ];

  List<Page> get _onBoardingStack => [
        MaterialPage(
            child: OnboardingScreen(
          goLogin: () {
            isLogIn = null;
            notifyListeners();
          },
          key: const ValueKey('OnBoardingScreen'),
        ))
      ];

  List<Page> get _loggoutStack => [
        MaterialPage(
            child: LoginScreen(
          goRegister: () {
            isRegister = true;
            notifyListeners();
          },
          onLogin: () {
            isLogIn = true;
            notifyListeners();
          },
          key: const ValueKey('LoginScreen'),
        )),
        if (isRegister)
          MaterialPage(
              child: RegisterScreen(
            goLogin: () {
              isLogIn = null;
              isRegister = false;
              notifyListeners();
            },
            key: const ValueKey('RegisterScreen'),
          ))
      ];

  List<Page> get _logginStack => [
        MaterialPage(
            child: HomeScreen(
          isLogout: () {
            isLogIn = null;
            notifyListeners();
          },
          onTapped: (Story storyId) {
            selectedStory = storyId;
            notifyListeners();
          },
          key: const ValueKey('HomeScreen'),
        )),
        if (selectedStory != null)
          MaterialPage(
              child: DetailScreen(
            story: selectedStory!,
          ))
      ];

  set isOnboarding(bool value) {
    _isOnboarding = value;
    notifyListeners();
  }

  bool get isOnboarding => _isOnboarding;

  @override
  Widget build(BuildContext context) {
    if (isLogIn == true) {
      historyStack = _logginStack;
    } else if (isLogIn == null) {
      historyStack = _loggoutStack;
    } else if (isOnboarding) {
      historyStack = _onBoardingStack;
    } else {
      historyStack = _splashStack;
    }
    return Navigator(
      key: _navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        isRegister = false;
        selectedStory = null;
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
