import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/router/routes.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/utils_messages.dart';
import 'package:instagram_clone/features/add_post/presentation/cubit/posts_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../../auth/domain/entities/user_data_entity.dart';
import '../../data/models/media_model.dart';
import '../../domain/entities/post_entity.dart';
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
  final PostsCubit _postsCubit = PostsCubit.getInstance();
  final AudioPlayer _audioPlayer = AudioPlayer();
  UserDataEntity? _userDataEntity;
  @override
  void initState() {
    super.initState();
    loadSelectedMedia();
  }

  Future<void> loadSelectedMedia() async {
    final file = await widget.selectedMedias?[0].assetEntity.file;
    if (file != null) {
      _imageBytes = await file.readAsBytes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      bloc: _postsCubit,
      listener: (context, state) async {
        if (state is PostsSuccess) {
          context.pushReplacementNamed(Routes.mainWidget);
          await _audioPlayer.play(AssetSource('post_uploaded.mp3'));
        } else if (state is PostsFailure) {
          UtilsMessages.showToastErrorBottom(context,
              message: AppStrings.somethingWentWrong);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text(
                  context.translate(AppStrings.newPost),
                  style: CustomTextStyle.pacifico13,
                ),
                actions: [
                  //TODO upload more than one image
                  if (_imageBytes != null)
                    UploadUserPostWidget(
                      image: _imageBytes!,
                      description: description ?? "",
                      onPost: () async {
                        final postEntity = PostEntity(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          userName: _userDataEntity?.username ?? '',
                          imageUrl: _imageBytes.toString(),
                          timesTamp: DateTime.now(),
                          description: description ?? "",
                        );
                        await _postsCubit.createPost(
                          image: _imageBytes!,
                          post: postEntity,
                          folderName: 'post_images',
                        );
                      },
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
                      },
                    ),
                    leading: Image(
                      width: 50,
                      image: AssetEntityImageProvider(
                        widget.selectedMedias![index].assetEntity,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state is PostsLoading)
              Container(
                color: Colors.black45,
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primaryColor,
                    size: 100,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
