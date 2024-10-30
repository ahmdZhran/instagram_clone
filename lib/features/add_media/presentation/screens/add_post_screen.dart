import 'package:flutter/material.dart';
import 'package:instagram_clone/features/add_media/presentation/widgets/picker_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: const PickImagePostWidget(
        selectedMedias: [],
      ),
    );
  }
}
