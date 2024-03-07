import 'package:flutter/material.dart';

import '../../../../../core/utls/app_colors.dart';
import '../../../../../core/utls/spacer.dart';
import '../../../../../core/widgets/custom_button_widget.dart';
import 'photo_of_profile.dart';
import 'profile_count_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileCountWidget(count: '120', label: 'Following'),
            ProfileAvatarWidget(),
            ProfileCountWidget(count: '21.2k', label: 'Followers'),
          ],
        ),
        verticalSpacer(10),
        const Text(
          'Eren_official',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        verticalSpacer(5),
        const Text(
          'Hero of Attack on Titan',
        ),
        const Text(
          'youtube/attack_on_titan/official',
          style: TextStyle(color: Colors.blue),
        ),
        verticalSpacer(10),
        CustomButton(
          childOfCustomButton: const Text(
            'Edite Profile',
            style: TextStyle(color: AppColors.kWhiteColor),
          ),
          height: 40,
          width: 180,
          onPressed: () {},
        )
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../../../../core/utls/app_colors.dart';
// import '../../../../../core/utls/spacer.dart';
// import '../../../../../core/widgets/custom_button_widget.dart';
// import 'photo_of_profile.dart';
// import 'profile_count_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../view_model/profile_cubit/profile_cubit.dart';

// class ProfileInfoWidget extends StatelessWidget {
//   const ProfileInfoWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(
//       builder: (context, state) {
//         if (state is ProfileSuccess) {
//           final userModel = state.userModel;

//           return Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ProfileCountWidget(
//                       count: userModel.following.length.toString(),
//                       label: 'Following'),
//                   const ProfileAvatarWidget(), // Assuming you have this widget
//                   ProfileCountWidget(
//                       count: userModel.followers.length.toString(),
//                       label: 'Followers'),
//                 ],
//               ),
//               verticalSpacer(10),
//               Text(
//                 userModel.username,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               verticalSpacer(5),
//               Text(
//                 userModel.bio,
//               ),
//               Text(
//                 userModel.name,
//                 style: const TextStyle(color: Colors.blue),
//               ),
//               verticalSpacer(10),
//               CustomButton(
//                 childOfCustomButton: const Text(
//                   'Edit Profile',
//                   style: TextStyle(color: AppColors.kWhiteColor),
//                 ),
//                 height: 40,
//                 width: 180,
//                 onPressed: () {},
//               )
//             ],
//           );
//         } else if (state is ProfileLoading) {
//           return const CircularProgressIndicator(); // Show loading indicator while fetching data
//         } else if (state is ProfileFailer) {
//           return Text(
//               'Error: ${state.errMessage}'); // Show error message if data fetching fails
//         } else {
//           return const Text('Unknown state');
//         }
//       },
//     );
//   }
// }
