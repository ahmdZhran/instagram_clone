import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import 'selection_button_language_and_theme_widget.dart';
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
      centerTitle: false,
      pinned: ModalRoute.of(context)!.isFirst,
      floating: ModalRoute.of(context)!.isFirst,
      title: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSuccess) {
            return SizedBox(
              height: 00,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_profileCubit.userProfileData?.username ?? ""),
                      const Spacer(),
                      SelectionButtonLanguageAndThemeWidget(
                        profileCubit: _profileCubit,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              _profileCubit.userProfileData!.profileImageUrl,
                          width: 80.r,
                          height: 80.r,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // UserProfileInformationWidget(
                      //   postsCount: _profileCubit.postsCount?.toInt() ?? 0,
                      // )
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
