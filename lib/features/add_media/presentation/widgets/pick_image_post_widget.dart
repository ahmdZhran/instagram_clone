import 'package:flutter/material.dart';
import '../../data/models/media_model.dart';

class PickImagePostWidget extends StatefulWidget {
  final List<MediaModel> selectedMedias;

  const PickImagePostWidget({super.key, required this.selectedMedias});

  @override
  State<PickImagePostWidget> createState() => _PickImagePostWidgetState();
}

class _PickImagePostWidgetState extends State<PickImagePostWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
          ),
        ],
      ),
    );
  }
}
