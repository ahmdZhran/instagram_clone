import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/custom_text_style.dart';
import '../cubits/profile_cubit/profile_cubit.dart';

class UserNameWidget extends StatefulWidget {
  const UserNameWidget({super.key, required this.uid});
  final String uid;

  @override
  State<UserNameWidget> createState() => _UserNameWidgetState();
}

class _UserNameWidgetState extends State<UserNameWidget> {
  final profileCubit = ProfileCubit.getInstance();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: profileCubit,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Skeletonizer(
            child: Container(
              height: 25,
              width: 150,
              color: AppColors.greyColor,
            ),
          );
        } else {
          return Flexible(
            flex: 2,
            child: Text(
              profileCubit.userProfileData!.username,
              style: CustomTextStyle.pacifico25,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }
      },
    );
  }
}
