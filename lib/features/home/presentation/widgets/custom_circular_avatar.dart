import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: const CircleAvatar(
          child: ClipOval(
        child: Image(
          height: 90,
          width: 90,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/airen.jpg'),
        ),
      )),
    );
  }
}
