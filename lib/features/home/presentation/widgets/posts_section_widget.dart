import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'post_loading_shimmer_widget.dart';
import 'posts_list_widget.dart';

class PostsSectionWidget extends StatefulWidget {
  const PostsSectionWidget({super.key});

  @override
  State<PostsSectionWidget> createState() => _PostsSectionWidgetState();
}

class _PostsSectionWidgetState extends State<PostsSectionWidget> {
  final HomeCubit _homeCubit = HomeCubit.getInstance();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: _homeCubit,
        builder: (context, state) {
          if (state is HomePostsLoading) {
            return const PostsLoadingShimmerWidget();
          } else if (state is HomePostsFailure) {
            return const Center(child: Text('Failed to load posts'));
          } else if (state is HomePostsSuccess ) {
            return PostsListWidget(posts: state.posts ?? []);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
