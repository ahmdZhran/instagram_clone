import 'package:flutter/material.dart';

class UserProfileMentionedPostsWidget extends StatelessWidget {
  const UserProfileMentionedPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Image.asset('assets/images/airen.jpg'),
        ),
      ],
    );
  }
}
