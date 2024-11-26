import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:instagram_clone/core/widgets/custom_button_widget.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import 'edit_and_share_buttons_widget.dart';
import 'selection_bloc_builder_theme_and_language.dart';
import 'user_profile_information_widget.dart';

class UserProfileAppBarWidget extends StatefulWidget {
  const UserProfileAppBarWidget({super.key, required this.uid});
  final String uid;

  @override
  State<UserProfileAppBarWidget> createState() =>
      _UserProfileAppBarWidgetState();
}

class _UserProfileAppBarWidgetState extends State<UserProfileAppBarWidget> {
  final ProfileCubit _profileCubit = ProfileCubit.getInstance();

  @override
  void initState() {
    _profileCubit.getUserData(userId: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.h,
      centerTitle: false,
      pinned: ModalRoute.of(context)!.isFirst,
      floating: ModalRoute.of(context)!.isFirst,
      flexibleSpace: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSuccess) {
            return FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.h, top: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            _profileCubit.userProfileData?.username ?? "",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Spacer(),
                        const SelectionBlocBuilderThemeAndLanguage()
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ClipOval(
                          child: CircleAvatar(
                            radius: 40.r,
                            child: CachedNetworkImage(
                              imageUrl: _profileCubit
                                      .userProfileData?.profileImageUrl ??
                                  "this is now image to shown",
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            UserProfileInformationWidget(
                              postsCount:
                                  _profileCubit.postsCount?.toInt() ?? 0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    EditAndShareButtonsWidget(profileCubit: _profileCubit),
                    const Gap(20),
                    AutoSizeText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      _profileCubit.userProfileData?.name ?? "",
                      style: CustomTextStyle.pacifico14,
                    ),
                    const Gap(10),
                    AutoSizeText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      _profileCubit.userProfileData?.bio ?? "",
                      style: CustomTextStyle.pacifico14,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
