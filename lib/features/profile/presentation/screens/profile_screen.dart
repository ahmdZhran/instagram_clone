import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../widgets/user_posts_widget.dart';
import '../widgets/user_profile_bar_delegate_widget.dart';
import '../widgets/user_profile_mentioned_posts_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../widgets/user_profile_sliver_app_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.uid});
  final String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _nestedScrollController;
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    _nestedScrollController = ScrollController();
    profileCubit = ProfileCubit.getInstance(widget.uid);
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
                    UserProfileSliverAppBarWidget(uid: widget.uid),
                    const Gap(20),
                    const SliverPersistentHeader(
                      pinned: true,
                      delegate: UserProfileBarDelegateWidget(
                        TabBar(
                          physics: NeverScrollableScrollPhysics(),
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          indicatorWeight: 1,
                          tabs: [
                            Tab(icon: Icon(Icons.grid_on)),
                            Tab(icon: Icon(Icons.person_outline)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(top: 140.0),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                UserPostsGridView(uid: widget.uid),
                const UserProfileMentionedPostsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nestedScrollController.dispose();
    ProfileCubit.deleteInstance();
    super.dispose();
  }
}
