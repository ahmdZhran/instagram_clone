import 'package:flutter/material.dart';
import '../widgets/instagram_media_picker.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InstagramMediaPicker(),
    );
  }
}
