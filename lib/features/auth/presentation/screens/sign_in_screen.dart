import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'this is our log in ya ',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
