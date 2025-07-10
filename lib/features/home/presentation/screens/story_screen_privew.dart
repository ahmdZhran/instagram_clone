import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryPreviewScreen extends StatefulWidget {
  final Uint8List? selectedImage;

  const StoryPreviewScreen({super.key, required this.selectedImage});

  @override
  StoryPreviewScreenState createState() => StoryPreviewScreenState();
}

class StoryPreviewScreenState extends State<StoryPreviewScreen> {
  final List<StoryElement> _storyElements = [];
  final TextEditingController _captionController = TextEditingController();
  // final StoryCubit _storyCubit = StoryCubit.getInstance();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _addText() {
    showDialog(
      context: context,
      builder: (context) => TextInputDialog(
        onTextAdded: (text) {
          setState(() {
            _storyElements.add(
              StoryElement(type: StoryElementType.text, content: text),
            );
          });
        },
      ),
    );
  }

  void _addSticker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StickerSelectionSheet(
        onStickerSelected: (sticker) {
          setState(() {
            _storyElements.add(
              StoryElement(type: StoryElementType.sticker, content: sticker),
            );
          });
        },
      ),
    );
  }

  void _showCaptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Caption'),
        content: TextField(
          controller: _captionController,
          decoration: const InputDecoration(
            hintText: 'Write a caption...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _shareStory() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to share stories')),
      );
      return;
    }

    if (widget.selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Selected Image: ${widget.selectedImage}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Story Preview'),
        actions: [
          TextButton(
            onPressed: _shareStory,
            child: const Text('Share'),
          )
        ],
      ),
      body: Stack(
        children: [
          if (widget.selectedImage != null)
            Image.memory(
              widget.selectedImage!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ..._storyElements
              .map((element) => Positioned(child: _buildStoryElement(element))),
          if (_captionController.text.isNotEmpty)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((0.7 * 255).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _captionController.text,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.text_fields, color: Colors.white),
              onPressed: _addText,
            ),
            IconButton(
              icon: const Icon(Icons.emoji_emotions, color: Colors.white),
              onPressed: _addSticker,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: _showCaptionDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryElement(StoryElement element) {
    switch (element.type) {
      case StoryElementType.text:
        return Positioned(
          top: 100,
          left: 20,
          child: Text(
            element.content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              shadows: const [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        );
      case StoryElementType.sticker:
        return Positioned(
          top: 200,
          left: 20,
          child: SvgPicture.asset(
            element.content,
            width: 100.w,
            height: 100.h,
          ),
        );
    }
  }
}

class TextInputDialog extends StatelessWidget {
  final Function(String) onTextAdded;

  const TextInputDialog({super.key, required this.onTextAdded});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return AlertDialog(
      title: const Text('Add Text'),
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: 'Enter your text'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onTextAdded(textController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        )
      ],
    );
  }
}

class StickerSelectionSheet extends StatelessWidget {
  final Function(String) onStickerSelected;

  const StickerSelectionSheet({super.key, required this.onStickerSelected});

  @override
  Widget build(BuildContext context) {
    final stickerPaths = [
      'assets/svg/just_follow.svg',
      'assets/svg/just_follow.svg',
      'assets/svg/just_follow.svg',
    ];

    return SizedBox(
      height: 200.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: stickerPaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onStickerSelected(stickerPaths[index]);
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(stickerPaths[index]),
          );
        },
      ),
    );
  }
}

enum StoryElementType { text, sticker }

class StoryElement {
  final StoryElementType type;
  final String content;

  StoryElement({required this.type, required this.content});
}
