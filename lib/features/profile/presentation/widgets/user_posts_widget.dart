import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/user_posts/user_posts_cubit.dart';
import 'custom_grid_view_with_shimmer_effect.dart';

class UserPostsGridView extends StatefulWidget {
  const UserPostsGridView({super.key, required this.uid});

  final String uid;

  @override
  State<UserPostsGridView> createState() => _UserPostsGridViewState();
}

class _UserPostsGridViewState extends State<UserPostsGridView> {
  late final UserPostsCubit _userPostsCubit;

  @override
  void initState() {
    super.initState();
    _userPostsCubit = UserPostsCubit.getInstance();
    _userPostsCubit.getUserPosts(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostsCubit, UserPostsState>(
      bloc: _userPostsCubit,
      builder: (context, state) {
        if (state is UserPostsLoading) {
          return const CustomGridViewWithShimmerEffectWidget();
        } else if (state is UserPostsFailure) {
          return const Text('the is something went wrong');
        } else if (state is UserPostsSuccess) {
          final posts = _userPostsCubit.postsList ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return CachedNetworkImage(
                imageUrl: post.postImageUrl,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
                fit: BoxFit.cover,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    UserPostsCubit.deleteInstance();
    super.dispose();
  }
}
