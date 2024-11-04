import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/services/media_services.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../core/utils/custom_text_style.dart';

class MediaPickerWidget extends StatefulWidget {
  const MediaPickerWidget(
      {super.key, required this.maxCount, required this.requestType});
  final int maxCount;
  final RequestType requestType;
  @override
  State<MediaPickerWidget> createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends State<MediaPickerWidget> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetsList = [];
  @override
  void initState() {
    MediaServices().loadAlbums(widget.requestType).then((value) {
      setState(() {
        selectedAlbum = value[0];
        albumList = value;
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
    return SizedBox(
      height: 40.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(selectedAlbum?.name ?? "Select Album",
                style: CustomTextStyle.pacifico20),
            IconButton(
              icon: const Icon(Iconsax.arrow_down_1),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.builder(
                      itemCount: albumList.length,
                      itemBuilder: (context, index) {
                        final album = albumList[index];
                        return ListTile(
                          title: Text(album.name),
                          onTap: () {
                            setState(() {
                              selectedAlbum = album;
                            });
                            context.pop();
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.multiple_stop),
            ),
            IconButton(
              enableFeedback: true,
              icon: const Icon(Icons.camera),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
