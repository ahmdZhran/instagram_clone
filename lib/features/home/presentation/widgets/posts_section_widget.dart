import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/posts/presentation/cubit/posts_cubit.dart';
import 'post_loading_shimmer_widget.dart';
import 'posts_list_widget.dart';

class PostsSectionWidget extends StatefulWidget {
  const PostsSectionWidget({super.key});

  @override
  State<PostsSectionWidget> createState() => _PostsSectionWidgetState();
}

class _PostsSectionWidgetState extends State<PostsSectionWidget> {
  final PostsCubit _postsCubit = PostsCubit.getInstance();

  @override
  void initState() {
    super.initState();
    _postsCubit.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<PostsCubit, PostsState>(
        bloc: _postsCubit,
        builder: (context, state) {
          if (state is PostsLoading) {
            return const PostsLoadingShimmerWidget();
          } else if (state is PostsFailure) {
            return const Center(child: Text('Failed to load posts'));
          } else if (state is PostsSuccess) {
            return PostsList(posts: state.posts ?? []);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}








