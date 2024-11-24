import 'package:flutter/material.dart';
import 'package:instagram_clone/features/explore/presentation/cubit/explore_cubit.dart';
import '../widgets/search_for_user_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    ExploreCubit.getInstance();
    super.initState();
  }

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

  @override
  void dispose() {
    ExploreCubit.deleteInstance();
    super.dispose();
  }
}
