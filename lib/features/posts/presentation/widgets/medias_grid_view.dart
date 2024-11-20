import 'package:flutter/material.dart';
import 'package:instagram_clone/features/posts/data/models/media_model.dart';
import 'package:instagram_clone/features/posts/presentation/widgets/media_item.dart';

class MediasGridView extends StatelessWidget {
  final List<MediaModel> medias;
  final List<MediaModel> selectedMedias;
  final Function(MediaModel) selectMedia;
  final ScrollController scrollController;

  const MediasGridView({
    super.key,
    required this.medias,
    required this.selectedMedias,
    required this.selectMedia,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
            ),
            itemCount: medias.length,
            itemBuilder: (context, index) {
              return MediaItem(
                media: medias[index],
                isSelected: selectedMedias.any((element) =>
                    element.assetEntity.id == medias[index].assetEntity.id),
                selectMedia: selectMedia,
              );
            },
          ),
        ),
      ],
    );
  }
}
