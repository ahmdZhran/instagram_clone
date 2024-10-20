
import 'package:flutter/material.dart';

import '../../../../core/utils/custom_text_style.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Text(
        '___ahmd.1',
        style: CustomTextStyle.pacifico25,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
