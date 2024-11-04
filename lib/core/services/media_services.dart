import 'package:photo_manager/photo_manager.dart';

class MediaServices {
  Future loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumsList = [];
    if (permission.isAuth == true) {
      albumsList = await PhotoManager.getAssetPathList(type: requestType);
    } else {
      return [];
    }
    return albumsList;
  }

  Future loadAssets(AssetPathEntity selectedAlbum) async {
    int assetCount = await selectedAlbum.assetCountAsync;
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0,
      end: assetCount,
    );
    return assetList;
  }
}
