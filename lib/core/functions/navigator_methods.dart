import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// void customNavigator(context, String path) {
//   GoRouter.of(context).push(path);
// }

// void customReplacementNavigate(context, String path) {
//   GoRouter.of(context).pushReplacement(path);
// }

extension NavigationHelper on BuildContext {
  void customNavigate(String path) {
    GoRouter.of(this).push(path);
  }

  void customReplacementNavigate(String path) {
    GoRouter.of(this).pushReplacement(path);
  }
}
