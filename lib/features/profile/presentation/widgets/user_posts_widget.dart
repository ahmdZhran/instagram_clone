import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';

import '../../data/models/user_post_model.dart';

class UserPostsWidget extends StatefulWidget {
  const UserPostsWidget({super.key});

  @override
  State<UserPostsWidget> createState() => _UserPostsWidgetState();
}

class _UserPostsWidgetState extends State<UserPostsWidget> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final ProfileCubit _profileCubit = ProfileCubit.getInstance();
  @override
  void initState() {
    _profileCubit.getUserPosts(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, state) {
        if (state is UserPostsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserPostsFailure) {
          return Center(child: Text('Error: ${state.errMessage}'));
        }
        if (state is UserPostsSuccess) {
          final List<UserPostModel> posts = state.posts;
          if (posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          return GridView.builder(
            itemCount: posts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final post = posts[index];

              final imageUrl = post.postImageUrl;
              print('Image URL for post $index: ${post.postImageUrl}');
              return SizedBox(
                child: CachedNetworkImage(
                  imageUrl: imageUrl.isNotEmpty
                      ? imageUrl
                      : 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
