import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelItemWidget extends StatefulWidget {
  const ReelItemWidget({super.key, this.snapshot});
  final snapshot;
  @override
  State<ReelItemWidget> createState() => _ReelItemWidgetState();
}

class _ReelItemWidgetState extends State<ReelItemWidget> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.snapshot['videoUrl'])
          ..initialize().then((value) => setState(() {
                _videoPlayerController.setLooping(true);
                _videoPlayerController.play();
              }));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: VideoPlayer(_videoPlayerController),
        )
      ],
    );
  }
}
