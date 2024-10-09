import 'package:flutter/material.dart';

import '../../../../core/utils/custom_text_style.dart';

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
