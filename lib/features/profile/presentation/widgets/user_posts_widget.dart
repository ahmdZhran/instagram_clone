import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserPostsWidget extends StatelessWidget {
  const UserPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 40,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 20,
          width: 20,
          child: Image.asset('assets/images/airen.jpg'),
        );
      },
    );
  }
}
