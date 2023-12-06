// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';

class CardStory extends StatelessWidget {
  const CardStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reyhan',
            style: myTextTheme.headline4,
          ),
          const SizedBox(height: 20),
          Text(
            'Donec eleifend hendrerit purus et dignissim. Nunc lacinia lorem ut eros scelerisque, quis semper felis accumsan. Proin tempus dolor ex, at convallis mauris sollicitudin sit amet.',
            style: myTextTheme.subtitle1!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/stories.png'),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
              const Text('129'),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
              const Text('29'),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ],
          )
        ],
      ),
    );
  }
}
