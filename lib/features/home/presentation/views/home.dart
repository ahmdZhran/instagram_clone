import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/post_section/post_section_widget.dart';
import '../widgets/story_section/story_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: CustomAppBarWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            const SliverToBoxAdapter(
              child: StorySection(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 1000,
                child: ListView.builder(
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: PostSectoin(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
