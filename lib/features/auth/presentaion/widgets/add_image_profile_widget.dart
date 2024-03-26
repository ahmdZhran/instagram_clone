import 'package:flutter/material.dart';

class AddImageProfileWidget extends StatelessWidget {
  const AddImageProfileWidget({
    super.key,
  });

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
