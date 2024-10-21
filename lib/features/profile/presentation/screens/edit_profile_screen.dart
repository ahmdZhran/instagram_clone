import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: Text(
          context.translate(AppStrings.editProfile),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
                Text('')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
