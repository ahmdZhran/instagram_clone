import 'package:flutter/material.dart';

import 'media_picker_widget.dart';
import 'picked_image_interaction_widget.dart';

class PickImagePostWidget extends StatefulWidget {
  const PickImagePostWidget({super.key});

  @override
  PickImagePostWidgetState createState() => PickImagePostWidgetState();
}

class PickImagePostWidgetState extends State<PickImagePostWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          PickerImageInteractionWidget(),
          MediaPickerWidget(),
        ],
      ),
    );
  }
}
