import 'package:flutter/material.dart';
import 'package:instagram_clone/core/theme/colors_extension.dart';

extension ExtensionsHelper on BuildContext {



  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }
  void pop() => Navigator.of(this).pop();

  ColorsExtension get color => Theme.of(this).extension<ColorsExtension>()!;
}