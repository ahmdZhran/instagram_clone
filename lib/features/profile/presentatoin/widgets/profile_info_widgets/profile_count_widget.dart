import 'package:flutter/material.dart';

class ProfileCountWidget extends StatelessWidget {
  final String count;
  final String label;

  const ProfileCountWidget(
      {super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label),
      ],
    );
  }
}
