import 'package:flutter/material.dart';
import 'package:instagram_clone/features/profile/presentatoin/views/saved_view_section/book_marked.dart';

import 'feed_view_section/feed.dart';
import 'reals_view_sectoin/reals.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  static const List<Widget> taps = [
    Tab(icon: Icon(Icons.photo)),
    Tab(icon: Icon(Icons.tag_rounded)),
    Tab(icon: Icon(Icons.bookmark_border)),
  ];
  final List<Widget> tabBarView = [
    const FeedView(),
    const RealsView(),
    const BookMarkView(),
  ];

  List<Widget> _createTabs() {
    return List<Widget>.from(taps);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [TabBar(tabs: _createTabs())],
        ),
      ),
    );
  }
}
