import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:instagram_clone/features/add_media/presentation/widgets/media_picker_widget.dart';
import 'package:instagram_clone/features/add_media/presentation/widgets/picked_image_interaction_widget.dart';

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
          MediaPickerWidget(
            maxCount: 5,
            requestType: RequestType.image,
          ),
        ],
      ),
    );
  }
}
