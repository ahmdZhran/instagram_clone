import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: ProfileCubit.getInstance(),
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Skeletonizer(
            child: Container(
              height: 25,
              width: 150,
              color: AppColors.greyColor,
            ),
          );
        } else if (state is ProfileSuccess) {
          return Flexible(
            flex: 2,
            child: Text(
              state.userData!.username,
              style: CustomTextStyle.pacifico25,
              overflow: TextOverflow.ellipsis,
            ),
          );
        } else if (state is ProfileFailure) {
          return AutoSizeText(
            maxLines: 1,
            maxFontSize: 10.sp,
            state.errMessage,
            style: const TextStyle(color: Colors.red, fontSize: 10),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
