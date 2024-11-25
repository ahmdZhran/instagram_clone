import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'selection_button_language_and_theme_widget.dart';

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
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_profileCubit.userProfileData?.username ?? ""),
                const Spacer(),
                SelectionButtonLanguageAndThemeWidget(
                  profileCubit: _profileCubit,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
