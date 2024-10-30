import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/picker_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        actions: [
          IconButton(
            icon: Icon(
            context.isEnglish
                  ? Iconsax.arrow_right_1
                  : Iconsax.arrow_left_1,
              color: AppColors.primaryColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const PickImagePostWidget(
        selectedMedias: [],
      ),
    );
  }
}
