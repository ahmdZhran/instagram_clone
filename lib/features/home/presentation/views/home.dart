import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/story_section/story_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBarWidget(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: StorySection(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverToBoxAdapter(
              child: PostSectoin(),
            )
          ],
        ),
      ),
    ));
  }
}

class PostSectoin extends StatelessWidget {
  const PostSectoin({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 500.0,
      borderRadius: 25.0,
      linearGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.1),
        ],
      ),
      border: 0,
      blur: 40,
      borderGradient: const LinearGradient(
        colors: [Colors.pink, Colors.teal],
      ),
      child: const Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Column(
            children: [
              ListTile(
                leading: StorySection(),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
