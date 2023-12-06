// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/widgets/cardstory_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble),
        label: 'Chat',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      )
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Cocials',
          style: myTextTheme.headline2!.copyWith(color: primaryYellow2),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CardStory(),
            SizedBox(height: 20),
            CardStory(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
      ),
    );
  }
}
