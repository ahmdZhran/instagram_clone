import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../widgets/user_profile_mentioned_posts_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../widgets/user_posts_widget.dart';
import '../widgets/user_profile_app_bar_widget.dart';
import '../widgets/user_profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});
  final String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _nestedScrollController;
  final profileCubit = ProfileCubit.getInstance();
  @override
  void initState() {
    _nestedScrollController = ScrollController();
    profileCubit.getUserData(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
          dragStartBehavior: DragStartBehavior.start,
          controller: _nestedScrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: MultiSliver(
                  children: [
                    UserProfileAppBarWidget(uid: widget.uid),
                    const Gap(20),
                    const UserProfileHeaderWidget(),
                    SliverPersistentHeader(
                      pinned: ModalRoute.of(context)!.isFirst,
                      delegate: const _UserProfileBarDelegate(
                        TabBar(
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          indicatorWeight: 1,
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.grid_on,
                              ),
                            ),
                            Tab(
                              icon: Icon(Icons.person_outline),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(top: 82.h),
            child: const TabBarView(
              children: [
                UserPostsWidget(),
                UserProfileMentionedPostsWidget(),
              ],
            ),
          )),
    ));
  }

  @override
  void dispose() {
    _nestedScrollController.dispose();
    super.dispose();
  }
}

class _UserProfileBarDelegate extends SliverPersistentHeaderDelegate {
  const _UserProfileBarDelegate(this.tabBar);
  final TabBar tabBar;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _UserProfileBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
