import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> grantPermissions() async {
  try {
    final bool videosGranted = await Permission.videos.isGranted;
    final bool photosGranted = await Permission.photos.isGranted;

    if (!photosGranted || !videosGranted) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.videos,
        Permission.photos,
      ].request();

      if (statuses[Permission.videos] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.photos] == PermissionStatus.permanentlyDenied) {
        [];
      }
    }
  } catch (e) {
    debugPrint('Error granting permissions: $e');
  }
}
