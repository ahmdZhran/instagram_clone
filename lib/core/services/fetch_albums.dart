import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'grant_permission.dart';

Future<List<AssetPathEntity>> fetchAlbums({
  RequestType type = RequestType.image,
}) async {
  try {
    await grantPermissions();

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: type,
    );

    return albums;
  } catch (e) {
    debugPrint('Error fetching albums: $e');
    return [];
  }
}
