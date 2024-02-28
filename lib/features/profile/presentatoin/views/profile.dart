import 'package:flutter/material.dart';
import 'package:instagram_clone/features/profile/presentatoin/views/saved_view_section/book_marked.dart';
import '../widgets/profile_info_widgets/profile_info_widget.dart';
import 'feed_view_section/feed.dart';
import 'reals_view_sectoin/reals.dart';

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
        body: SafeArea(
          child: Column(
            children: [
              const ProfileInfoWidget(),
              Column(
                children: [
                  TabBar(
                    tabs: _tabs,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Expanded(
                child: TabBarView(children: _tabBarView),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
