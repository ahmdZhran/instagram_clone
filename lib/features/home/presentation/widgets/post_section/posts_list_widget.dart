import 'package:flutter/material.dart';

import 'post_section_widget.dart';

class PostsListWidget extends StatelessWidget {
  const PostsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: ListView.builder(
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: PostSectoin(),
        ),
      ),
    );
  }
}
