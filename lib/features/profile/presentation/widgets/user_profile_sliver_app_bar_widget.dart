import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import 'custom_shimmer_effect_widgets.dart';
import 'edit_and_share_buttons_widget.dart';
import 'profile_image_and_info.dart';
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
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit.getInstance(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 267.h,
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
          } else if (state is ProfileSuccess || state is ProfileFollowUpdated) {
            return FlexibleSpaceBar(
              background: _UserProfileContent(
                profileCubit: _profileCubit,
                uid: widget.uid,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _UserProfileContent extends StatelessWidget {
  const _UserProfileContent({required this.profileCubit, required this.uid});
  final ProfileCubit profileCubit;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserHeader(
            profileCubit: profileCubit,
            uid: uid,
          ),
          const Gap(16),
          ProfileImageAndInfo(profileCubit: profileCubit),
          const Gap(20),
          EditAndShareButtonsWidget(
            profileCubit: profileCubit,
            uid: uid,
          ),
          const Gap(20),
          _UserDetails(profileCubit: profileCubit),
        ],
      ),
    );
  }
}

class _UserHeader extends StatelessWidget {
  const _UserHeader({required this.profileCubit, required this.uid});
  final ProfileCubit profileCubit;
  final String uid;
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
        if (uid == FirebaseAuth.instance.currentUser!.uid)
          const SelectionBlocBuilderThemeAndLanguage(),
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
