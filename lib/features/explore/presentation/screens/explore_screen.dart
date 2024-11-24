import 'package:flutter/material.dart';
import '../widgets/search_for_user_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
        child: Column(
          children: [
            SearchForUserWidget(),
          ],
        ),
      ),
    );
  }
}
