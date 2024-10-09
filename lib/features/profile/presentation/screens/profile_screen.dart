import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../widgets/user_profile_app_bar_widget.dart';
import '../widgets/user_profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _nestedScrollController;
  @override
  void initState() {
    _nestedScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
        controller: _nestedScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: MultiSliver(
                children: const [
                  UserProfileAppBarWidget(),
                  Gap(20),
                  UserProfileHeaderWidget()
                ],
              ),
            )
          ];
        },
        body: const Column(
          children: [],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _nestedScrollController.dispose();
    super.dispose();
  }
}
