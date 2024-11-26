import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/profile_cubit/profile_cubit.dart';

class UserPostsGridView extends StatefulWidget {
  const UserPostsGridView({super.key, required this.uid});

  final String uid;

  @override
  State<UserPostsGridView> createState() => _UserPostsGridViewState();
}

class _UserPostsGridViewState extends State<UserPostsGridView> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit.getInstance();
    _profileCubit.getUserPosts(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: _profileCubit,
      builder: (context, state) {
        if (state is UserPostsFailure) {
          return const Center(child: Text('Something went wrong'));
        } else {
          final posts = _profileCubit.postsList ?? [];
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
      },
    );
  }
}
