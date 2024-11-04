import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

import 'gride_painter_widget.dart';

class PickerImageInteractionWidget extends StatefulWidget {

  const PickerImageInteractionWidget({super.key});

  @override
  PickerImageInteractionWidgetState createState() =>
      PickerImageInteractionWidgetState();
}

class PickerImageInteractionWidgetState
    extends State<PickerImageInteractionWidget> {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _position = Offset.zero;
  Offset _startPosition = Offset.zero;
  bool _isInteracting = false;

  void resetImage() {
    setState(() {
      _scale = 1.0;
      _position = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          GestureDetector(
            onScaleStart: (details) {
              _previousScale = _scale;
              _startPosition = details.focalPoint - _position;
              setState(() {
                _isInteracting = true;
              });
            },
            onScaleUpdate: (details) {
              setState(() {
                // Handle scaling
                _scale = (_previousScale * details.scale).clamp(1.0, 4.0);

                // Handle dragging
                final maxX = (320.w * (_scale - 1)) / 2;
                final maxY = (350.h * (_scale - 1)) / 2;
                final offset = details.focalPoint - _startPosition;
                _position = Offset(
                  offset.dx.clamp(-maxX, maxX),
                  offset.dy.clamp(-maxY, maxY),
                );
              });
            },
            onScaleEnd: (details) {
              setState(() {
                _isInteracting = false;
              });
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(_position.dx, _position.dy)
                ..scale(_scale),
              child: SizedBox(
                height: 350.h,
                width: 320.w,
                child: Image.asset(
                  'assets/images/profile_image/post1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (_isInteracting)
            Positioned.fill(
              child: CustomPaint(
                painter: GridPainter(),
              ),
            ),
          Positioned(
            bottom: 10,
            left: context.isEnglish ? 10 : null,
            right: context.isArabic ? 10 : null,
            child: ElevatedButton(
              onPressed: resetImage,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                backgroundColor: AppColors.deepGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                context.translate(AppStrings.reset),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
