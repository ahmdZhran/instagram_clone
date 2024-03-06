import 'package:flutter/material.dart';
import '../widgets/saved_view_section/book_marked.dart';
import '../widgets/profile_info_widgets/profile_info_widget.dart';
import '../widgets/feed_view_section/feed.dart';
import '../widgets/reals_view_sectoin/reals.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final List<Widget> _tabs = [
    const Tab(icon: Icon(Icons.photo)),
    const Tab(icon: Icon(Icons.tag_rounded)),
    const Tab(icon: Icon(Icons.bookmark_border)),
  ];

  final List<Widget> _tabBarView = [
    const FeedView(),
    const RealsView(),
    const BookMarkView(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: ListView(
          children: [
            const ProfileInfoWidget(),
            TabBar(
              tabs: _tabs,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 1430,
              child: TabBarView(children: _tabBarView),
            ),
          ],
        ),
      ),
    );
  }
}
