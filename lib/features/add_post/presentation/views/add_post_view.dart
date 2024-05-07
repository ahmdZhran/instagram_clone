import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:instagram_clone/features/add_post/data/services/local/media_services/media_services.dart';
import 'package:instagram_clone/features/add_post/presentation/views/asset_thumbnail.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  List<AssetEntity> assetList = [];

  List<AssetPathEntity> albumList = [];

  AssetPathEntity? selectedAlbum;

  AssetEntity? selectedEntity;

  bool isMultible = false;
  Future<void> _fetchAssets() async {
    assetList = await PhotoManager.getAssetListRange(
      start: 0,
      end: 10000,
    );
    setState(() {});
  }

  @override
  void initState() {
    MediaServices().loadAlbums(RequestType.common).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[0];
        });
        MediaServices().loadAssets(selectedAlbum!).then((value) {
          setState(() {
            selectedEntity = assetList[0];
            assetList = value;
          });
        });
      },
    );
    _fetchAssets();
    super.initState();
  }

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text("Add Post"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.5,
            child: selectedEntity == null
                ? const SizedBox.shrink()
                : Stack(
                    children: [
                      Positioned.fill(
                          child: AssetThumbnail(
                        asset: selectedEntity!,
                        isSelected: false,
                      )),
                      if (selectedEntity!.type == AssetType.video)
                        const Positioned.fill(
                          child: Center(
                            child: Icon(
                              size: 50,
                              Icons.play_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
          GestureDetector(
            onTap: () {
              albums(height);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  if (selectedAlbum != null)
                    Text(
                      selectedAlbum!.name == "Recent"
                          ? "Gallery"
                          : selectedAlbum!.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  const Icon(
                    Icons.expand_more,
                    size: 25,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: isMultible
                        ? const Icon(
                            Iconsax.note_21,
                          )
                        : const Icon(
                            Iconsax.note_2_copy,
                          ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.camera_copy,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: GridView.builder(
              itemCount: assetList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                final isSelected = assetList[index] == selectedEntity;
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEntity = assetList[index];
                      });
                    },
                    child: AssetThumbnail(
                      asset: assetList[index],
                      isSelected: isSelected,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  void albums(height) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      context: context,
      builder: (context) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                setState(() {
                  selectedAlbum = albumList[index];
                });
                Navigator.pop(context);
                MediaServices().loadAssets(selectedAlbum!).then((value) {
                  setState(() {
                    assetList = value;
                  });
                });
              },
              title: Text(
                albumList[index].name == "Recent"
                    ? "Gallery"
                    : albumList[index].name,
                style: const TextStyle(fontSize: 20),
              ),
            );
          },
          itemCount: albumList.length,
        );
      },
    );
  }
}
