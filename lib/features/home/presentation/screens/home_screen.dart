import 'package:flutter/material.dart';
import '../widgets/custom_sliver_app_bar_widget.dart';
import '../widgets/story_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        clipBehavior: Clip.none,
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBarWidget(),
          StorySectionWidget(),
        ],
      ),
    );
  }
}
