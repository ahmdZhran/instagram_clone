import 'package:flutter/material.dart';
import 'package:instagram_clone/features/posts/data/models/media_model.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

import 'package:video_player/video_player.dart';

Future<List<MediaModel>> fetchMedias({
  required AssetPathEntity album,
  required int page,
  AssetType type = AssetType.image,
}) async {
  List<MediaModel> medias = [];

  try {
    final List<AssetEntity> entities =
        await album.getAssetListPaged(page: page, size: 30);

    final filteredEntities = entities.where((e) => e.type == type).toList();

    for (AssetEntity entity in filteredEntities) {
      Widget mediaWidget;

      if (entity.type == AssetType.video) {
        final file = await entity.file;
        final controller = VideoPlayerController.file(file!);
        await controller.initialize();

        mediaWidget = VideoPlayer(controller);
      } else {
        mediaWidget = FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          fit: BoxFit.cover,
          image: AssetEntityImageProvider(
            entity,
            thumbnailSize: const ThumbnailSize.square(500),
            isOriginal: false,
          ),
        );
      }

      medias.add(MediaModel(
        assetEntity: entity,
        widget: mediaWidget,
      ));
    }
  } catch (e) {
    debugPrint('Error fetching media: $e');
  }

  return medias;
}
