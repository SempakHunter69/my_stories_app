import 'package:flutter/material.dart';
import 'package:my_stories_app/data/model/stories_response.dart';
import 'package:my_stories_app/widgets/cardstory_widget.dart';

class DetailScreen extends StatelessWidget {
  final Story story;

  const DetailScreen({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Details'),
      ),
      body: SingleChildScrollView(child: CardStory(story: story)),
    );
  }
}
