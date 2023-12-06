import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryYellow2,
      body: Center(
        child: Image.asset(
          'assets/icon.png',
          width: 150,
        ),
      ),
    );
  }
}
