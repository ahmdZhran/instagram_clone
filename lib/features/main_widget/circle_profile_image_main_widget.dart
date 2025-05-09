import 'package:flutter/material.dart';
import 'package:instagram_clone/core/helper/extensions.dart';

class CircleProfileImageMainWidget extends StatelessWidget {
  const CircleProfileImageMainWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: index == 4 ? context.color.mainColor : Colors.transparent,
          width: 2.0,
        ),
      ),
      child: const CircleAvatar(
        radius: 15,
        backgroundImage: AssetImage("assets/images/airen.jpg"),
      ),
    );
  }
}
