import 'package:flutter/material.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../data/models/media_model.dart';

class AddDescriptionToPostScreen extends StatelessWidget {
  final List<MediaModel>? selectedMedias;

  const AddDescriptionToPostScreen({super.key, required this.selectedMedias});

  @override
  Widget build(BuildContext context) {
    print("Received selectedMedias: $selectedMedias");

    if (selectedMedias == null || selectedMedias!.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No images selected")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Description"),
      ),
      body: ListView.builder(
        itemCount: selectedMedias!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Image ${index + 1}'),
            leading: Image(
              image: AssetEntityImageProvider(
                selectedMedias![index].assetEntity,
              ),
            ),
          );
        },
      ),
    );
  }
}
