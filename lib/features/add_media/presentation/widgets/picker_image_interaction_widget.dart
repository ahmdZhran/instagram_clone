import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import '../../data/models/media_model.dart';
import 'build_grid_overlay_widget.dart';

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
  double _scale = 1.0;
  bool _showGrid = false;

  void _resetImage() {
    setState(() {
      _scale = 1.0;
      _dragOffset = Offset.zero;
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
              onPanUpdate: (details) {
                setState(() {
                  _dragOffset += details.delta;
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  InteractiveViewer(
                    panEnabled: true,
                    scaleEnabled: true,
                    clipBehavior: Clip.none,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Transform.translate(
                        offset: _dragOffset, // Apply offset directly here
                        child: Image(
                          image: AssetEntityImageProvider(
                            widget._selectedMedias[index].assetEntity,
                            isOriginal: true,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Conditionally render the grid overlay
                  if (_showGrid) const BuildGridOverlayWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
