// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/data/model/stories_response.dart';

class StoryWidget extends StatelessWidget {
  final Story story;
  const StoryWidget({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            story.name,
            style: myTextTheme.headline4,
          ),
          const SizedBox(height: 20),
          Text(
            story.description,
            style: myTextTheme.subtitle1!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            story.createdAt.toString(),
            style: myTextTheme.subtitle1!.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10),
          Image.network(story.photoUrl),
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
