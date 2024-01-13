// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';
import 'package:my_stories_app/data/model/stories_response.dart';

class CardStory extends StatelessWidget {
  final Story story;
  final Function(double lat, double lon) cekLokasiUser;
  const CardStory({
    super.key,
    required this.story,
    required this.cekLokasiUser,
  });

  @override
  Widget build(BuildContext context) {
    final lat = story.lat ?? 0;
    final lon = story.lon ?? 0;
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
          const SizedBox(height: 20),
          Image.network(story.photoUrl),
          const SizedBox(height: 10),
          story.lat == null && story.lon == null
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    cekLokasiUser(lat, lon);
                  },
                  child: const Text(
                    'Cek lokasi',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
