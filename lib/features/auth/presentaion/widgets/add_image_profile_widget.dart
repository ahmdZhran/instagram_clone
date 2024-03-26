import 'package:flutter/material.dart';

class AddImageProfileWidget extends StatefulWidget {
  const AddImageProfileWidget({super.key});

  @override
  State<AddImageProfileWidget> createState() => _AddImageProfileWidgetState();
}

class _AddImageProfileWidgetState extends State<AddImageProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey[300],
      child: Icon(
        Icons.add_a_photo,
        size: 60,
        color: Colors.grey[600],
      ),
    );
  }
}
