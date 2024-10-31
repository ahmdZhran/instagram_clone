import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../features/add_media/data/models/media_model.dart';

class MediaService {
  Future<List<AssetPathEntity>> fetchAlbums() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      return [];
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
    );
    return albums;
  }

  Future<List<MediaModel>> fetchMedias({
    required AssetPathEntity album,
    required int page,
  }) async {
    const int pageSize = 20;
    final assets = await album.getAssetListPaged(
      page: page,
      size: pageSize,
    );

    final medias = assets.map((asset) {
      return MediaModel(
        assetEntity: asset,
        widget: AssetEntityImage(
          asset,
          fit: BoxFit.cover,
        ),
      );
    }).toList();

    return medias;
  }
}
