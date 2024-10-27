import 'package:flutter/material.dart';

class UserProfileBarDelegateWidget extends SliverPersistentHeaderDelegate {
  const UserProfileBarDelegateWidget(this.tabBar);
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
  bool shouldRebuild(covariant UserProfileBarDelegateWidget oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
