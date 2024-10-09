import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/custom_text_style.dart';
import 'package:sliver_tools/sliver_tools.dart';

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

class UserProfileAppBarWidget extends StatelessWidget {
  const UserProfileAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      pinned: ModalRoute.of(context)!.isFirst,
      floating: ModalRoute.of(context)!.isFirst,
      title: Row(
        children: [
          Flexible(
            flex: 12,
            child: Text(
              '___ahmd.1',
              style: CustomTextStyle.pacifico25,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
