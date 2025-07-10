import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/widgets/custom_button_widget.dart';
import 'package:instagram_clone/core/widgets/custom_text_form_field.dart';
import 'package:instagram_clone/core/widgets/custom_text_widget.dart';
import 'package:instagram_clone/features/posts/data/models/media_model.dart';
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

  @override
  void initState() {
    super.initState();
    _initializeVideoController();
  }

  Future<void> _initializeVideoController() async {
    if (widget.selectedMedias == null || widget.selectedMedias!.isEmpty) return;

    try {
      final file = await widget.selectedMedias![0].assetEntity.file;
      if (file == null) return;

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
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(text: AppStrings.newReel),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  child:
                      !_isInitializing && _videoController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: context.translate(AppStrings.writeACaption),
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              CustomButton(
                // width: 40.w,
                height: 30.h,
                onPressed: () {},
                childOfCustomButton: CustomTextWidget(text: AppStrings.share),
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
