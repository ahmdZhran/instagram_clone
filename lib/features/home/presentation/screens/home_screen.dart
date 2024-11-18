import 'package:flutter/material.dart';
import '../widgets/custom_sliver_app_bar_widget.dart';
import '../widgets/posts_section_widget.dart';
import '../widgets/story_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          clipBehavior: Clip.none,
          physics: BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBarWidget(),
            StorySectionWidget(),
            PostsSectionWidget()
          ],
        ),
      ),
    );
  }
}
