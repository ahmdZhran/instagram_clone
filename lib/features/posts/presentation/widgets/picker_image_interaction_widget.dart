import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'gride_painter_widget.dart';
import '../../data/models/media_model.dart';

class PickerImageInteractionWidget extends StatefulWidget {
  const PickerImageInteractionWidget({
    super.key,
    required List<MediaModel> selectedMedias,
  }) : _selectedMedias = selectedMedias;

  final List<MediaModel> _selectedMedias;

  @override
  State<PickerImageInteractionWidget> createState() =>
      _PickerImageInteractionWidgetState();
}

class _PickerImageInteractionWidgetState
    extends State<PickerImageInteractionWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _startOffset = Offset.zero;
  bool _showGrid = false;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation =
        Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_controller)
          ..addListener(() {
            setState(() {
              _offset = _animation.value;
            });
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetImage() {
    setState(() {
      _scale = 1.0;
      _offset = Offset.zero;
      _showGrid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Only show the first selected image since we only allow one selection
    if (widget._selectedMedias.isEmpty) {
      return SizedBox(
        height: 350.h,
        child: Center(
          child: Text(context.translate(AppStrings.sleetedYourPost)),
        ),
      );
    }

    return SizedBox(
      height: 350.h,
      child: Center(
        child: Stack(
          children: [
            GestureDetector(
              onScaleStart: (details) {
                _previousScale = _scale;
                _startOffset = details.focalPoint - _offset;
                setState(() => _showGrid = true);
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = _previousScale * details.scale;
                  _offset = details.focalPoint - _startOffset;
                });
              },
              onScaleEnd: (_) {
                setState(() => _showGrid = false);

                if (_scale == 1.0) {
                  _controller.reset();
                  _animation = Tween<Offset>(begin: _offset, end: Offset.zero)
                      .animate(_controller);
                  _controller.forward();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..translate(_offset.dx, _offset.dy)
                      ..scale(_scale),
                    child: Image(
                      image: AssetEntityImageProvider(
                        widget._selectedMedias.first.assetEntity,
                      ),
                    ),
                  ),
                  if (_showGrid)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: GridPainter(),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    left: 10,
                    child: ElevatedButton(
                      onPressed: _resetImage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1),
                      ),
                      child: Text(
                        context.translate(AppStrings.reset),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
