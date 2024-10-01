import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaddingWrapperWidget extends StatelessWidget {
  final Widget child;

  const PaddingWrapperWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: child,
    );
  }
}

class PaddingTopWrapperWidget extends StatelessWidget {
  final Widget child;

  const PaddingTopWrapperWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.r),
      child: child,
    );
  }
}
