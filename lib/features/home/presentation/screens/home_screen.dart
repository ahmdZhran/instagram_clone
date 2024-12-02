import 'package:flutter/material.dart';
import 'package:instagram_clone/features/home/presentation/cubits/cubit/home_cubit.dart';
import '../widgets/custom_sliver_app_bar_widget.dart';
import '../widgets/posts_section_widget.dart';
import '../widgets/story_section_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit _homeCubit = HomeCubit.getInstance();

  @override
  void initState() {
    _homeCubit.fetchPosts();
    super.initState();
  }

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

  @override
  void dispose() {
    HomeCubit.deleteInstance();
    super.dispose();
  }
}
