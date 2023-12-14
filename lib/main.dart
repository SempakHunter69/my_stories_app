import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/data/api/api_service.dart';
import 'package:my_stories_app/data/preferences/preferences_helper.dart';
import 'package:my_stories_app/provider/navigation_provider.dart';
import 'package:my_stories_app/provider/preferences_provider.dart';
import 'package:my_stories_app/provider/story_provider.dart';
import 'package:my_stories_app/provider/user_provider.dart';
import 'package:my_stories_app/routes/router_delegate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate myRouterDelegate;
  late PreferencesProvider preferencesProvider;

  @override
  void initState() {
    super.initState();

    final preferencesHelper =
        PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());

    preferencesProvider =
        PreferencesProvider(preferencesHelper: preferencesHelper);
    myRouterDelegate = MyRouterDelegate(preferencesHelper);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        myRouterDelegate.isOnboarding = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => StoryProvider(
            apiService: ApiService(),
            preferencesProvider:
                Provider.of<PreferencesProvider>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Stories',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryYellow,
                onPrimary: primaryYellow2,
                secondary: primaryDark,
              ),
          textTheme: myTextTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryYellow2,
            ),
          ),
        ),
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
