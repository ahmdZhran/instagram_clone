import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit? fit;
  final Duration cacheDuration;
  final Widget? placeholder;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.cacheDuration = const Duration(days: 1),
    this.placeholder,
  });

  @override
  State<CustomCachedNetworkImage> createState() =>
      _CustomCachedNetworkImageState();
}

class _CustomCachedNetworkImageState extends State<CustomCachedNetworkImage> {
  static final _cache = <String, ui.Image>{};
  static final _expiryTimes = <String, DateTime>{};
  late Timer _cleanupTimer;
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _cleanupTimer = Timer.periodic(const Duration(minutes: 1), _cleanupCache);
  }

  @override
  void dispose() {
    _cleanupTimer.cancel();
    super.dispose();
  }

  Future<void> _loadImage() async {
    final now = DateTime.now();

    // Check if the image is in the cache and valid
    if (_cache.containsKey(widget.imageUrl) &&
        _expiryTimes[widget.imageUrl]?.isAfter(now) == true) {
      setState(() {
        _image = _cache[widget.imageUrl];
      });
      return;
    }

    // Fetch the image from the network
    try {
      final imageStream = NetworkImage(widget.imageUrl).resolve(
        const ImageConfiguration(),
      );
      final completer = Completer<ui.Image>();

      imageStream.addListener(
        ImageStreamListener((ImageInfo info, _) {
          completer.complete(info.image);
        }),
      );

      final fetchedImage = await completer.future;

      // Cache the image
      _cache[widget.imageUrl] = fetchedImage;
      _expiryTimes[widget.imageUrl] = now.add(widget.cacheDuration);

      setState(() {
        _image = fetchedImage;
      });
    } catch (e) {
      debugPrint('Failed to load image: $e');
    }
  }

  void _cleanupCache(Timer timer) {
    final now = DateTime.now();
    _expiryTimes.keys
        .where((key) => _expiryTimes[key]?.isBefore(now) == true)
        .toList()
        .forEach((key) {
      _cache.remove(key);
      _expiryTimes.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_image != null) {
      return RawImage(
        image: _image,
        fit: widget.fit,
      );
    }

    return widget.placeholder ??
        const Center(
          child: CircularProgressIndicator(),
        );
  }
}
