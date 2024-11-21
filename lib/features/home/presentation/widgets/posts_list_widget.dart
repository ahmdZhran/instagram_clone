import 'package:flutter/material.dart';
import '../../../posts/domain/entities/post_entity.dart';
import 'post_card_widget.dart';

class PostsListWidget extends StatelessWidget {
  final List<PostEntity> posts;
  final ScrollController? scrollController;

  const PostsListWidget({
    required this.posts,
    this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(post: post);
      },
    );
  }
}
