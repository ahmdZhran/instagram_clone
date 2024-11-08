import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaModel {
  // Represents a media asset managed by photo_manager
  final AssetEntity assetEntity;
  // Represents a Flutter widget associated with the asset
  final Widget widget;
  MediaModel({
    required this.assetEntity,
    required this.widget,
  });
}