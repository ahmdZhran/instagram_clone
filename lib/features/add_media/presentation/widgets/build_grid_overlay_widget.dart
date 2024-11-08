import 'package:flutter/material.dart';

import 'gride_painter_widget.dart';

class BuildGridOverlayWidget extends StatelessWidget {
  const BuildGridOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
