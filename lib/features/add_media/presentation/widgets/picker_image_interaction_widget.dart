import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import '../../data/models/media_model.dart';
import 'gride_painter_widget.dart';

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
    extends State<PickerImageInteractionWidget> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _startOffset = Offset.zero;
  bool _showGrid = false;

  void _resetImage() {
    setState(() {
      _scale = 1.0;
      _offset = Offset.zero;
      _showGrid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: PageView.builder(
        itemCount: widget._selectedMedias.length,
        itemBuilder: (context, index) {
          return Center(
            child: GestureDetector(
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
                _previousScale = 1.0;
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
                        widget._selectedMedias[index].assetEntity,
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
                      style: ElevatedButton.styleFrom(),
                      child: const Text("Reset"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
