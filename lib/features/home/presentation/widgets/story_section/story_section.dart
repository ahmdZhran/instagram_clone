import 'package:flutter/material.dart';

import '../custom_circular_avatar.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CustomCircularAvatar(
            widthOfContainer: 80,
            heightOfImage: 90,
            widthOfImage: 90,
            margin: EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
