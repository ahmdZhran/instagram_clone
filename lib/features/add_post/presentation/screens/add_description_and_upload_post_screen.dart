import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/add_post/presentation/cubit/posts_cubit.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../data/models/media_model.dart';
import '../widgets/upload_user_post_widget.dart';

class AddDescriptionAndUploadPostScreen extends StatefulWidget {
  final List<MediaModel>? selectedMedias;

  const AddDescriptionAndUploadPostScreen({
    super.key,
    required this.selectedMedias,
  });

  @override
  State<AddDescriptionAndUploadPostScreen> createState() =>
      _AddDescriptionAndUploadPostScreenState();
}

class _AddDescriptionAndUploadPostScreenState
    extends State<AddDescriptionAndUploadPostScreen> {
  @override
  void initState() {
    PostsCubit.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      bloc: PostsCubit.getInstance(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.translate(AppStrings.newPost),
              style: CustomTextStyle.pacifico13,
            ),
            actions: [
              FutureBuilder<Uint8List>(
                future: widget.selectedMedias![0].assetEntity.file
                    .then((file) => file!.readAsBytes()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Text('Error loading image');
                  } else {
                    return UploadUserPostWidget(
                      image: snapshot.data!,
                      description: ' descriptionController.text',
                    );
                  }
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: TextField(
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: context.translate(
                          AppStrings.addDescription,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    leading: Image(
                      image: AssetEntityImageProvider(
                        widget.selectedMedias![index].assetEntity,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
