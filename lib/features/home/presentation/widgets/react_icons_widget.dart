import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_assets.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';
import '../../../../core/theme/app_them.dart';
import '../cubits/cubit/home_cubit.dart';

class ReactIconsWidget extends StatefulWidget {
  final String postId;
  final String userId;

  const ReactIconsWidget({
    super.key,
    required this.postId,
    required this.userId,
  });

  @override
  State<ReactIconsWidget> createState() => _ReactIconsWidgetState();
}

class _ReactIconsWidgetState extends State<ReactIconsWidget> {
  final HomeCubit _homeCubit = HomeCubit.getInstance();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      builder: (context, state) {
        if (state is HomePostsSuccess) {
          final post =
              state.posts?.firstWhere((post) => post.id == widget.postId);
          final isLiked = post?.likes.contains(widget.userId) ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _homeCubit.toggleLikedPost(widget.postId, widget.userId);
                  },
                  child: isLiked as bool
                      ? const ThemedSvgIcon(
                          assetName: AppAssets.heartActiveIcon,
                          colorFilter: ColorFilter.mode(
                              AppColors.redColor, BlendMode.srcIn),
                        )
                      : const ThemedSvgIcon(
                          assetName: AppAssets.heartIcon,
                        ),
                ),
                const Gap(6),
                Text(post?.likes.length.toString() ?? "0"),
                const Gap(10),
                InkWell(
                  onTap: () => _showCommentsBottomSheet(context),
                  child: const ThemedSvgIcon(
                    assetName: AppAssets.commentIcon,
                  ),
                ),
                const Gap(6),
                const Text('203'),
                const Gap(10),
                const ThemedSvgIcon(
                  assetName: AppAssets.shareIcon,
                ),
                const Gap(6),
                const Text('1k'),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/airen.jpg"),
                      ),
                      title: Text('User name'),
                      subtitle: Text('This is owner comment '),
                    ),
                    const Divider(
                      color: AppColors.greyColor,
                      endIndent: 20,
                      indent: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/airen.jpg"),
                            ),
                            title: Text('User $index'),
                            subtitle: Text('This is comment $index'),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              hintText:
                                  context.translate(AppStrings.addYourComment),
                            ),
                          ),
                          const Gap(8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
