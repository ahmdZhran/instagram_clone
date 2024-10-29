import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnailWidget extends StatelessWidget {
  const AssetThumbnailWidget({
    super.key,
    required this.asset,
    required this.isSelected,
    this.isMultiple = false,
  });
  final AssetEntity asset;
  final bool isSelected;
  final bool isMultiple;
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
              ),
            if (isMultiple == true)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
