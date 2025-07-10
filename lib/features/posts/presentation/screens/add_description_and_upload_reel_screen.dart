import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/cubits/profile_cubit/profile_cubit.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/utils/utils_messages.dart';
import 'package:instagram_clone/core/widgets/custom_button_widget.dart';
import 'package:instagram_clone/core/widgets/custom_text_widget.dart';
import 'package:instagram_clone/features/posts/data/models/media_model.dart';
import 'package:instagram_clone/features/posts/data/models/reel_model.dart';
import 'package:instagram_clone/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:instagram_clone/features/profile/data/models/user_model.dart';
import 'package:video_player/video_player.dart';

class AddDescriptionAndUploadReelScreen extends StatefulWidget {
  const AddDescriptionAndUploadReelScreen({super.key, this.selectedMedias});
  final List<MediaModel>? selectedMedias;

  @override
  State<AddDescriptionAndUploadReelScreen> createState() =>
      _AddDescriptionAndUploadReelScreenState();
}

class _AddDescriptionAndUploadReelScreenState
    extends State<AddDescriptionAndUploadReelScreen> {
  late VideoPlayerController _videoController;
  bool _isInitializing = true;

  late final PostsCubit _postsCubit;
  late final ProfileCubit _profileCubit;
  Uint8List? _videoBytes;
  UserProfileDataModel? _userProfileData;
  final TextEditingController _captionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _postsCubit = PostsCubit.getInstance();
    _profileCubit = ProfileCubit.getInstance();
    _initializeVideoController();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    await Future.wait([
      _fetchUserData(),
    ]);
  }

  Future<void> _fetchUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await _profileCubit.getUserData(userId: userId);
    _userProfileData = _profileCubit.getUserProfileData;
  }

  Future<void> _initializeVideoController() async {
    if (widget.selectedMedias == null || widget.selectedMedias!.isEmpty) return;

    try {
      final file = await widget.selectedMedias![0].assetEntity.file;
      if (file == null) return;
      _videoBytes = await file.readAsBytes();
      _videoController = VideoPlayerController.file(file)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitializing = false;
            });
            _videoController.setLooping(true);
            _videoController.setVolume(1.0);
            _videoController.play();
          }
        });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    _videoController.dispose();
    // PostsCubit.deleteInstance();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(text: AppStrings.newReel),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsCubit, PostsState>(
        bloc: _postsCubit,
        listener: (context, state) {
          if (state is AddReelSuccess) {
            context.pop();
          } else if (state is AddReelFailure) {
            UtilsMessages.showToastErrorBottom(context,
                message: state.errorMessage);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                spacing: 10.h,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 428.h,
                      width: 270.w,
                      child: !_isInitializing &&
                              _videoController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                  TextField(
                    controller: _captionController,
                    decoration: InputDecoration(
                      hintText: context.translate(AppStrings.writeACaption),
                      hintStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  CustomButton(
                    height: 30.h,
                    isLoading: state is AddReelLoading, 
                    onPressed: () {
                      _postsCubit.createReel(
                        videoUrl: _videoBytes!,
                        reel: ReelModel(
                          description: _captionController.text.trim(),
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          username: _userProfileData!.username,
                          userProfileImage: _userProfileData!.profileImageUrl,
                          timestamp: DateTime.now(),
                          likes: [],
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                        ),
                        folderName:
                            'Reels/${FirebaseAuth.instance.currentUser!.uid}',
                      );
                    },
                    childOfCustomButton: state is AddReelLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator())
                        : const CustomTextWidget(text: AppStrings.share),
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
