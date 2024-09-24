import 'package:flutter/material.dart';

import '../presentation/manager/auth_cubit.dart';

class PickProfileImage extends StatelessWidget {
  const PickProfileImage({
    super.key,
    required this.auth,
  });

  final AuthCubit auth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        auth.profileImage != null
            ? CircleAvatar(
                radius: 50,
                backgroundImage: MemoryImage(auth.profileImage!),
              )
            : CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.add_a_photo,
                  size: 60,
                  color: Colors.grey[600],
                ),
              ),
      ],
    );
  }
}
