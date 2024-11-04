import 'package:flutter/material.dart';
import 'package:instagram_clone/features/add_media/data/models/media_model.dart';

import 'media_item.dart';
class MediaGridView extends StatelessWidget {
  final List<MediaModel> medias;
  final List<MediaModel> selectedMedias;
  final Function(MediaModel) selectMedia;
  final ScrollController scrollController;
  const MediaGridView(
      {super.key,
      required this.medias,
      required this.selectedMedias,
      required this.selectMedia,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: medias.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 3,
        crossAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        return MediaItem(
          media: medias[index],
          isSelected: selectedMedias.any((element) =>
              element.assetEntity.id == medias[index].assetEntity.id),
          selectMedia: selectMedia,
        );
      },
    );
  }
}