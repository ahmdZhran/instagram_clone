import 'dart:io';

import 'package:flutter/material.dart';

class StoryPreviewScreen extends StatelessWidget {
  final String imagePath; 

  const StoryPreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Story"),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Story posted successfully!")),
              );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
            tooltip: "Post Story",
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Feature coming soon!")),
                );
              },
              child: const Text("Add Text"),
            ),
          ),
        ],
      ),
    );
  }
}
