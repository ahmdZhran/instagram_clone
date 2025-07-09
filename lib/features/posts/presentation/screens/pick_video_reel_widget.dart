import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:instagram_clone/core/widgets/custom_text_widget.dart';
import 'package:instagram_clone/features/posts/data/models/media_model.dart';

class PickVideoReelWidget extends StatefulWidget {
  final List<MediaModel> selectedMedias;
  final ValueChanged<List<MediaModel>> onSelectionChanged;

  const PickVideoReelWidget({
    super.key,
    required this.selectedMedias,
    required this.onSelectionChanged,
  });

  @override
  State<PickVideoReelWidget> createState() => _PickVideoReelWidgetState();
}

class _PickVideoReelWidgetState extends State<PickVideoReelWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomTextWidget(
        text: AppStrings.selectYourReel,
      ),
    );
  }
  // Similar implementation to PickImagePostWidget but filtering for videos
  // You can reuse most of the code but modify the media fetching to only get videos
  // and adjust the preview widget for videos
}
