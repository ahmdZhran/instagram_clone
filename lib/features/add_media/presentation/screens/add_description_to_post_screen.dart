import 'package:flutter/material.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../data/models/media_model.dart';

class AddDescriptionToPostScreen extends StatelessWidget {
  final List<MediaModel>? selectedMedias;

  const AddDescriptionToPostScreen({super.key, required this.selectedMedias});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Description"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text('Image'),
            leading: Image(
              image: AssetEntityImageProvider(
                selectedMedias![index].assetEntity,
              ),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
