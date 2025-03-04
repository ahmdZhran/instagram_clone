import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class StoryPreviewScreen extends StatefulWidget {
  final Uint8List? selectedImage;

  const StoryPreviewScreen({super.key, required this.selectedImage});

  @override
  StoryPreviewScreenState createState() => StoryPreviewScreenState();
}

class StoryPreviewScreenState extends State<StoryPreviewScreen> {
  final List<StoryElement> _storyElements = [];

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

  void _shareStory() {
    // Implement story sharing logic
    Navigator.of(context).pop(_storyElements);
  }

  @override
  Widget build(BuildContext context) {
    log("Selected Image: ${widget.selectedImage}"); // Debugging

    return Scaffold(
      appBar: AppBar(
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
              Image.memory(
                  widget.selectedImage!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
          ..._storyElements
              .map((element) => Positioned(child: _buildStoryElement(element))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.text_fields),
              onPressed: _addText,
            ),
            IconButton(
              icon: const Icon(Icons.emoji_emotions),
              onPressed: _addSticker,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryElement(StoryElement element) {
    switch (element.type) {
      case StoryElementType.text:
        return Text(
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
        );
      case StoryElementType.sticker:
        return Image.asset(element.content, width: 100.w, height: 100.h);
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
