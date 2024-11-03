import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram_clone/core/helper/extensions.dart';
import 'package:instagram_clone/core/utils/app_colors.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';

class PickImagePostWidget extends StatefulWidget {
  const PickImagePostWidget({super.key});

  @override
  PickImagePostWidgetState createState() => PickImagePostWidgetState();
}

class PickImagePostWidgetState extends State<PickImagePostWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _position = Offset.zero;
  Offset _startPosition = Offset.zero;
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
  }

  void _resetImage() {
    setState(() {
      _scale = 1.0;
      _position = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRect(
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
                    onPressed: _resetImage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
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
          ),
          SizedBox(
            height: 40.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text('Recent'),
                  const Gap(10),
                  const Icon(Iconsax.arrow_down_1),
                  const Spacer(),
                  TextButton(
                    child: const Text('Select Multiple'),
                    onPressed: () {},
                  ),
                  IconButton(
                    enableFeedback: true,
                    icon: const Icon(Icons.camera),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1.0;

    int rows = 3;
    int columns = 3;
    double rowSpacing = size.height / rows;
    double columnSpacing = size.width / columns;

    for (int i = 1; i < columns; i++) {
      double x = columnSpacing * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (int i = 1; i < rows; i++) {
      double y = rowSpacing * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
