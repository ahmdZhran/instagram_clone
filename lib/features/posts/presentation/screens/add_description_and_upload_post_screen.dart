import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/services/token_device_manager.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/utils_messages.dart';
import '../../../profile/domain/entities/user_profile_entity.dart';
import '../../data/models/post_model.dart';
import '../cubit/posts_cubit.dart';
import '../../../../core/cubits/profile_cubit/profile_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_text_style.dart';
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
  late final PostsCubit _postsCubit;
  late final AudioPlayer _audioPlayer;
  late final ProfileCubit _profileCubit;

  final ValueNotifier<Uint8List?> _imageBytesNotifier = ValueNotifier(null);
  final ValueNotifier<String?> _descriptionNotifier = ValueNotifier(null);

  UserProfileEntity? _userProfileEntity;
  String? _deviceToken;

  @override
  void initState() {
    super.initState();
    _postsCubit = PostsCubit.getInstance();
    _audioPlayer = AudioPlayer();
    _profileCubit =
        ProfileCubit.getInstance(FirebaseAuth.instance.currentUser!.uid);

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    await Future.wait([
      _fetchUserData(),
      _fetchDeviceToken(),
      _loadSelectedMedia(),
    ]);
  }

  Future<void> _fetchDeviceToken() async {
    _deviceToken = await TokenDeviceManager().getToken();
  }

  Future<void> _fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await _profileCubit.getUserData(userId: userId);
    _userProfileEntity = _profileCubit.getUserProfileData;
  }

  Future<void> _loadSelectedMedia() async {
    final file = await widget.selectedMedias?[0].assetEntity.file;
    if (file != null) {
      _imageBytesNotifier.value = await file.readAsBytes();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    ProfileCubit.deleteInstance();
    _imageBytesNotifier.dispose();
    _descriptionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      bloc: _postsCubit,
      listener: (context, state) {
        if (state is PostsSuccess) {
          _audioPlayer.play(AssetSource('post_uploaded.mp3'));
          Future.delayed(const Duration(seconds: 1), () {
            context.pushReplacementNamed(Routes.mainWidget);
          });
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
                  ValueListenableBuilder<Uint8List?>(
                    valueListenable: _imageBytesNotifier,
                    builder: (context, imageBytes, child) {
                      if (imageBytes != null) {
                        return UploadUserPostWidget(
                          image: imageBytes,
                          description: _descriptionNotifier.value ?? "",
                          onPost: () async {
                            final postEntity = PostModel(
                              deviceToken: _deviceToken,
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              username: _userProfileEntity!.username,
                              imageUrl: imageBytes.toString(),
                              timestamp: DateTime.now(),
                              description: _descriptionNotifier.value ?? "",
                              likes: [],
                              userProfileImage:
                                  _userProfileEntity!.profileImageUrl,
                            );
                            await _postsCubit.createPost(
                              image: imageBytes,
                              post: postEntity,
                              folderName:
                                  'post_images/${FirebaseAuth.instance.currentUser!.uid}',
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder<String?>(
                    valueListenable: _descriptionNotifier,
                    builder: (context, description, child) {
                      return ListTile(
                        title: TextField(
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                            hintText:
                                context.translate(AppStrings.addDescription),
                          ),
                          onChanged: (value) {
                            _descriptionNotifier.value = value;
                          },
                        ),
                        leading: ValueListenableBuilder<Uint8List?>(
                          valueListenable: _imageBytesNotifier,
                          builder: (context, imageBytes, child) {
                            if (imageBytes != null) {
                              return Image(
                                width: 50,
                                image: MemoryImage(imageBytes),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      );
                    },
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
