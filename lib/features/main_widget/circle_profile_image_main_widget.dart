import 'package:flutter/material.dart';

class CircleProfileImageMainWidget extends StatelessWidget {
  const CircleProfileImageMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO pass the profile image here in the bottom nav bar
    return const CircleAvatar(
      radius: 15,
      backgroundImage: AssetImage("assets/images/airen.jpg"),
    );
  }
}
