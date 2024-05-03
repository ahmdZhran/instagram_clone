import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationHelper on BuildContext {
  void customNavigate(String path) {
    GoRouter.of(this).push(path);
  }

  void customReplacementNavigate(String path) {
    GoRouter.of(this).pushReplacement(path);
  }
}
