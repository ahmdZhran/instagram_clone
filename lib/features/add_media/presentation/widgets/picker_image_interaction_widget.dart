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
  Offset _dragOffset = Offset.zero;
  bool _showGrid = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: PageView.builder(
        itemCount: widget._selectedMedias.length,
        itemBuilder: (context, index) {
          return Center(
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _dragOffset += details.delta;
                  _dragOffset = Offset(
                    _dragOffset.dx.clamp(-30, 30),
                    _dragOffset.dy.clamp(-30, 30),
                  );
                });
              },
              onPanEnd: (_) {
                setState(() {
                  _dragOffset = Offset.zero;
                  _showGrid = false;
                });
              },
              onTapDown: (_) {
                setState(() {
                  _showGrid = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _showGrid = false;
                });
              },
              child: Transform.translate(
                offset: _dragOffset,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    InteractiveViewer(
                      panEnabled: false,
                      clipBehavior: Clip.none,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: AssetEntityImageProvider(
                            widget._selectedMedias[index].assetEntity,
                            isOriginal: true,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Conditionally render the grid overlay
                    if (_showGrid) _buildGridOverlay(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
      ),
      child: CustomPaint(
        size: Size.infinite,
        painter: GridPainter(),
      ),
    );
  }
}
