import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import 'custom_shimmer_effect_widgets.dart';
import 'edit_and_share_buttons_widget.dart';
import 'selection_bloc_builder_theme_and_language.dart';

class UserProfileSliverAppBarWidget extends StatefulWidget {
  const UserProfileSliverAppBarWidget({super.key, required this.uid});
  final String uid;

  @override
  State<UserProfileSliverAppBarWidget> createState() =>
      _UserProfileSliverAppBarWidgetState();
}

class _UserProfileSliverAppBarWidgetState
    extends State<UserProfileSliverAppBarWidget> {
  final ProfileCubit _profileCubit = ProfileCubit.getInstance();

  @override
  void initState() {
    super.initState();
    _profileCubit.getUserData(userId: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260.h,
      centerTitle: false,
      pinned: ModalRoute.of(context)!.isFirst,
      floating: ModalRoute.of(context)!.isFirst,
      flexibleSpace: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: CustomShimmerLoadingWidget(),
            ));
          } else if (state is ProfileSuccess) {
            return FlexibleSpaceBar(
              background: _UserProfileContent(profileCubit: _profileCubit),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _UserProfileContent extends StatelessWidget {
  const _UserProfileContent({required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserHeader(profileCubit: profileCubit),
          const Gap(16),
          _ProfileImageAndInfo(profileCubit: profileCubit),
          const Gap(20),
          EditAndShareButtonsWidget(profileCubit: profileCubit),
          const Gap(20),
          _UserDetails(profileCubit: profileCubit),
        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            profileCubit.userProfileData?.username ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Spacer(),
        const SelectionBlocBuilderThemeAndLanguage(),
      ],
    );
  }
}

class _ProfileImageAndInfo extends StatelessWidget {
  const _ProfileImageAndInfo({required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CircleAvatar(
            radius: 40.r,
            child: CachedNetworkImage(
              imageUrl: profileCubit.userProfileData?.profileImageUrl ??
                  "No image available",
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Gap(20),
        //TOdO pass the count of posts from user posts cubit
        // UserProfileInformationWidget(
        //   postsCount: profileCubit.postsCount?.toInt() ?? 0,
        // ),
      ],
    );
  }
}

class _UserDetails extends StatelessWidget {
  const _UserDetails({required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          profileCubit.userProfileData?.name ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.pacifico14,
        ),
        const Gap(10),
        AutoSizeText(
          profileCubit.userProfileData?.bio ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.pacifico14,
        ),
      ],
    );
  }
}
