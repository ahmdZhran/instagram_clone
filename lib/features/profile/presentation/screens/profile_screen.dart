import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../widgets/user_posts_widget.dart';
import '../widgets/user_profile_bar_delegate_widget.dart';
import '../widgets/user_profile_mentioned_posts_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../widgets/user_profile_app_bar_widget.dart';

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
    profileCubit.getUserData(userId: widget.uid);
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
                    // const UserProfileHeaderWidget(),
                    SliverPersistentHeader(
                      pinned: ModalRoute.of(context)!.isFirst,
                      delegate: const UserProfileBarDelegateWidget(
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
                //TOdO في معارضة هنا بين الحالات لو البروقايل نجح ف البوستات مش بتظهر والعكس
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
    ProfileCubit.deleteInstance();
    super.dispose();
  }
}
