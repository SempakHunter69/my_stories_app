// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            foregroundImage: AssetImage('assets/avatar.png'),
            radius: 50,
          ),
          const SizedBox(height: 15),
          Text(
            'Reyhan',
            style: myTextTheme.headline4,
          ),
          const SizedBox(height: 15),
          Text(
            'Aenean interdum risus nulla in purus convallis volutpat consectetur mi rhoncus eu lacinia est amet',
            textAlign: TextAlign.center,
            style: myTextTheme.subtitle1,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: textDarkGrey),
                onPressed: () {},
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Insight',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
