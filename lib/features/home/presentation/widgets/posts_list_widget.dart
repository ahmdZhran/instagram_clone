import 'package:flutter/material.dart';

import '../../../posts/domain/entities/post_entity.dart';
import 'post_card_widget.dart';

class PostsListWidget extends StatelessWidget {
  final List<PostEntity> posts;

  const PostsListWidget({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(post: post);
      },
    );
  }
}

