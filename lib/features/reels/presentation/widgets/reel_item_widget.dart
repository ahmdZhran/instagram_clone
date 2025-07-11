import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelItemWidget extends StatefulWidget {
  const ReelItemWidget({super.key, required this.snapshot});
  final Map<String, dynamic> snapshot;

  @override
  State<ReelItemWidget> createState() => _ReelItemWidgetState();
}

class _ReelItemWidgetState extends State<ReelItemWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.snapshot['videoUrl']));

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isInitialized)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        else
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
