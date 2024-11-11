import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/add_post/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/add_post/presentation/cubit/posts_cubit.dart';
import 'package:instagram_clone/features/auth/domain/entities/user_data_entity.dart';
import '../../../../core/helper/extensions.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/custom_text_style.dart';

class UploadUserPostWidget extends StatefulWidget {
  const UploadUserPostWidget(
      {super.key, required this.image, this.description});
  final Uint8List image;
  final String? description;

  @override
  State<UploadUserPostWidget> createState() => _UploadUserPostWidgetState();
}

class _UploadUserPostWidgetState extends State<UploadUserPostWidget> {
  final String? folderName = "post_image";

  UserDataEntity? _userDataEntity;

  final PostsCubit _postsCubit = PostsCubit.getInstance();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      bloc: _postsCubit,
      builder: (context, state) {
        return TextButton(
          onPressed: () async {
            final postEntity = PostEntity(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              userId: FirebaseAuth.instance.currentUser!.uid,
              userName: _userDataEntity!.username!,
              imageUrl: widget.image.toString(),
              timesTamp: DateTime.now(),
              description: widget.description,
            );
            await _postsCubit.createPost(
              image: widget.image,
              post: postEntity,
              folderName: folderName!,
            );
          },
          child: Text(
            context.translate(AppStrings.post),
            style: CustomTextStyle.pacifico14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
