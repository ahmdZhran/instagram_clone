// import 'package:flutter/material.dart';

// class ProfileAvatarWidget extends StatelessWidget {
//   const ProfileAvatarWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         height: 110,
//         width: 110,
//         decoration: const BoxDecoration(
//           color: Colors.grey,
//           shape: BoxShape.circle,
//         ),
//         child: ClipOval(
//           child: Image.asset(
//             'assets/images/airen.jpg',
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../view_model/profile_cubit/profile_cubit.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => _pickImage(context, profileCubit),
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _getImageProvider(state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ImageProvider _getImageProvider(ProfileState state) {
    if (state is ProfileInfoSuccess &&
        state.userProfile.profileImageUrl != null) {
      return NetworkImage(state.userProfile.profileImageUrl!);
    } else {
      return const AssetImage('assets/images/airen.jpg');
    }
  }

  Future<void> _pickImage(
      BuildContext context, ProfileCubit profileCubit) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imagePath = pickedImage.path;
      profileCubit.uploadProfileImage(imagePath);
    }
  }
}
