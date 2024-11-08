import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/features/add_media/data/models/media_model.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItem extends StatelessWidget {
  final MediaModel media;
  final bool isSelected;
  final Function selectMedia;

  const MediaItem({
    required this.media,
    required this.isSelected,
    required this.selectMedia,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMedia(media),
      child: Stack(
        children: [
          _buildMediaWidget(),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.15),
              child: media.assetEntity.type == AssetType.video
                  ? const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
          if (isSelected) _buildIsSelectedOverlay(),
        ],
      ),
    );
  }

  Widget _buildMediaWidget() {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(isSelected ? 10.0 : 0.0),
        // Display the media widget
        child: media.widget,
      ),
    );
  }

  Widget _buildIsSelectedOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: const Center(
          child: Icon(
            Icons.check_circle_rounded,
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
