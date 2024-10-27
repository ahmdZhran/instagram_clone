import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/media_services.dart';
import 'package:photo_manager/photo_manager.dart';

class InstagramMediaPicker extends StatefulWidget {
  const InstagramMediaPicker({super.key});

  @override
  State<InstagramMediaPicker> createState() => _InstagramMediaPickerState();
}

class _InstagramMediaPickerState extends State<InstagramMediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    MediaServices().loadAlbum(RequestType.common).then((value) {
      setState(() {
        albumList = value;
        selectedAssetList = value[0];
      });
      MediaServices().loadAssets(selectedAlbum!).then((value) {
        setState(() {
          assetList = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
