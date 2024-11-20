import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:instagram_clone/features/posts/presentation/cubit/posts_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'circle_profile_image_widget.dart';
import 'post_loading_shimmer_widget.dart';
import 'react_icons_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsSectionWidget extends StatefulWidget {
  const PostsSectionWidget({super.key});

  @override
  State<PostsSectionWidget> createState() => _PostsSectionWidgetState();
}

class _PostsSectionWidgetState extends State<PostsSectionWidget> {
  final PostsCubit _postsCubit = PostsCubit.getInstance();
  @override
  void initState() {
    _postsCubit.fetchPosts();
    super.initState();
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
            return const Center(
              child: Text('Failed to load posts'),
            );
          } else if (state is PostsSuccess) {
            final posts = state.posts;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                //TODO make the cusotm message here 
                final timeAgo =
                    timeago.format(post.timestamp, locale: 'custom');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 420.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.greyColor.withOpacity(0.5),
                                AppColors.greyColor.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                horizontalTitleGap: 10,
                                dense: true,
                                leading: CircleProfileImageWidget(
                                    userProfileImage: post.userProfileImage),
                                title: Text(post.username,
                                    style: CustomTextStyle.pacifico13),
                                subtitle: Text(timeAgo),
                                trailing: const Icon(Icons.more_horiz),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: SizedBox(
                                  width: 300.w,
                                  height: 300.h,
                                  child: InstaImageViewer(
                                    imageUrl: post.imageUrl,
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(post.imageUrl),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        overflow: TextOverflow.ellipsis,
                                        post.description.toString(),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              const ReactIconsWidget()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
