import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/services/fetch_albums.dart';
import 'package:instagram_clone/features/add_media/data/models/media_model.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../core/services/fetch_medias.dart';
import '../../../../core/utils/custom_text_style.dart';

class MediaPickerWidget extends StatefulWidget {
  const MediaPickerWidget({super.key});

  @override
  State<MediaPickerWidget> createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends State<MediaPickerWidget> {
  final List<MediaModel> _selectedMedia = [];
  final ScrollController _scrollController = ScrollController();
  AssetPathEntity? _currentAlbum;
  List<AssetPathEntity> _albumList = [];
  List<MediaModel> _mediaList = [];
  int _currentPage = 0;
  int _lastPage = 0;

  void loadMoreMedias() {
    if (_scrollController.position.pixels /
            _scrollController.position.maxScrollExtent >
        0.33) {
      if (_currentPage != _currentPage) {
        _loadMedias();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadAlbums();
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
            SizedBox(
              width: 70.w,
              child: AutoSizeText(
                maxLines: 1,
                _currentAlbum?.name ?? "Select Album",
                style: CustomTextStyle.pacifico17,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Iconsax.arrow_down_1),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.builder(
                      itemCount: _albumList.length,
                      itemBuilder: (context, index) {
                        final album = _albumList[index];
                        return ListTile(
                          title: Text(album.name),
                          onTap: () {
                            setState(() {
                              _currentAlbum = album;
                            });
                            Navigator.pop(context);
                            _loadMedias();
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
              onPressed: _showMediaFiles,
              icon: const Icon(Icons.multiple_stop),
            ),
            IconButton(
              icon: const Icon(Icons.camera),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void loadAlbums() async {
    List<AssetPathEntity> albums = await fetchAlbums();
    if (albums.isNotEmpty) {
      setState(() {
        _currentAlbum = albums.first;
        _albumList = albums;
      });
      _loadMedias();
    }
  }

  void _loadMedias() async {
    if (_currentAlbum != null) {
      List<MediaModel> medias =
          await fetchMedias(page: _currentPage, album: _currentAlbum!);
      setState(() {
        _mediaList = medias;
      });
    }
  }

  void _showMediaFiles() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: _mediaList.length,
          itemBuilder: (context, index) {
            final media = _mediaList[index];
            return ListTile(
              title: Text(media.assetEntity.id),
              onTap: () {
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
