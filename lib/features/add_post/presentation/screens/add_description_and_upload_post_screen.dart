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
  Uint8List? _imageBytes;
  String? description;
  @override
  void initState() {
    super.initState();
    loadSelectedMedia();
  }

  Future<void> loadSelectedMedia() async {
    final file = await widget.selectedMedias?[0].assetEntity.file;
    _imageBytes = await file!.readAsBytes();
    setState(() {});
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
              if (_imageBytes != null)
                UploadUserPostWidget(
                  image: _imageBytes!,
                  description: description ?? "",
                )
              else
                const Text('Error loading image'),
            ],
          ),
          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                title: TextField(
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: context.translate(
                      AppStrings.addDescription,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });

                    print(
                        'this is the value of description image $description');
                  },
                ),
                leading: Image(
                  image: AssetEntityImageProvider(
                    widget.selectedMedias![index].assetEntity,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
