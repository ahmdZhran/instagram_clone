import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SpacesHelper on BuildContext {
  horizontalSpacer(double width) => SizedBox(width: width.w);
  verticalSpacer(double height) => SizedBox(height: height.w);
}
