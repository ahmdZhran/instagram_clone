import 'dart:io';

import 'package:flutter/material.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  File? _selectedMedia;

  Future<void> _pickMedia() async {
    // Implement media picking logic
  }

  Future<void> _uploadStory() async {
    // Implement story upload logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Story')),
      body: Column(
        children: [
          _selectedMedia != null
              ? Image.file(_selectedMedia!)
              : const Text('No media selected'),
          ElevatedButton(
            onPressed: _pickMedia,
            child: const Text('Pick Media'),
          ),
          ElevatedButton(
            onPressed: _uploadStory,
            child: const Text('Upload Story'),
          ),
        ],
      ),
    );
  }
}
