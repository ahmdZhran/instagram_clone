import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail(
      {super.key, required this.asset, required this.isSelected});
  final AssetEntity asset;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asset.thumbnailData.then((value) => value),
      builder: (context, snapshot) { 
        final bytes = snapshot.data;
        if (bytes == null) {
          return const CircularProgressIndicator();
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image.memory(
                bytes,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            if (isSelected)
              Container(
                color: Colors.white60,
              )
          ],
        );
      },
    );
  }
}
