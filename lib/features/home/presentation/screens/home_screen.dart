import 'package:flutter/material.dart';
import '../cubits/home_cubit/home_cubit.dart';
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
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 80),
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
    //TODO need to think of it
    // HomeCubit.deleteInstance();
    super.dispose();
  }
}
