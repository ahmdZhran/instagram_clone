import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import '../../../../core/services/fetch_albums.dart';
import '../../../../core/services/fetch_medias.dart';
import '../../data/models/media_model.dart';
import 'medias_grid_view.dart';

class PickImagePostWidget extends StatefulWidget {
  final List<MediaModel> selectedMedias;

  const PickImagePostWidget({super.key, required this.selectedMedias});

  @override
  State<PickImagePostWidget> createState() => _PickImagePostWidgetState();
}

class _PickImagePostWidgetState extends State<PickImagePostWidget> {
  final ScrollController _scrollController = ScrollController();
  AssetPathEntity? _currentAlbum;
  List<AssetPathEntity> _albums = [];
  final List<MediaModel> _medias = [];
  int _lastPage = 0;
  int _currentPage = 0;
  final List<MediaModel> _selectedMedias = [];

  @override
  void initState() {
    super.initState();
    _selectedMedias.addAll(widget.selectedMedias);
    _loadAlbums();
    _scrollController.addListener(_loadMoreMedias);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreMedias);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadAlbums() async {
    List<AssetPathEntity> albums = await fetchAlbums();
    if (albums.isNotEmpty) {
      setState(() {
        _currentAlbum = albums.first;
        _albums = albums;
      });
      _loadMedias();
    }
  }

  void _loadMedias() async {
    _lastPage = _currentPage;
    if (_currentAlbum != null) {
      List<MediaModel> medias =
          await fetchMedias(album: _currentAlbum!, page: _currentPage);
      setState(() {
        _medias.addAll(medias);
      });
    }
  }

  void _loadMoreMedias() {
    if (_scrollController.position.pixels /
            _scrollController.position.maxScrollExtent >
        0.33) {
      if (_currentPage != _lastPage) {
        _loadMedias();
      }
    }
  }

  void _selectMedia(MediaModel media) {
    bool isSelected = _selectedMedias
        .any((element) => element.assetEntity.id == media.assetEntity.id);
    setState(() {
      if (isSelected) {
        _selectedMedias.removeWhere(
            (element) => element.assetEntity.id == media.assetEntity.id);
      } else {
        _selectedMedias.add(media);
      }
    });
  }

  void _showAlbumPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: _albums.length,
          itemBuilder: (context, index) {
            final album = _albums[index];
            return ListTile(
              title: Text(album.name.isEmpty ? "Unnamed Album" : album.name),
              onTap: () {
                setState(() {
                  _currentAlbum = album;
                  _currentPage = 0;
                  _lastPage = 0;
                  _medias.clear();
                });
                _loadMedias();
                _scrollController.jumpTo(0.0);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _selectedMedias.isNotEmpty
              ? SizedBox(
                  height: 350.h,
                  child: PageView.builder(
                    itemCount: _selectedMedias.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                            image: AssetEntityImageProvider(
                              _selectedMedias[index].assetEntity,
                              isOriginal: true,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 350.h,
                ),
          GestureDetector(
            onTap: _showAlbumPicker,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _currentAlbum?.name.isEmpty ?? true
                          ? "Unnamed Album"
                          : _currentAlbum!.name,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Gap(10),
                    const Icon(Iconsax.arrow_down_1),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: MediasGridView(
              medias: _medias,
              selectedMedias: _selectedMedias,
              selectMedia: _selectMedia,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
