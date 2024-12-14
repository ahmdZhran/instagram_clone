import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone/core/utils/app_strings.dart';
import '../languages/app_localization.dart';
import '../theme/colors_extension.dart';

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

  String translate(String langKey) {
    return AppLocalizations.of(this)!.translate(langKey).toString();
  }

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';
  bool get isEnglish => Localizations.localeOf(this).languageCode == 'en';
  bool get isDart => Theme.of(this).brightness == Brightness.dark;
  bool get isLight => Theme.of(this).brightness == Brightness.light;

  void showExitConfirmationDialog() {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.translate(AppStrings.exitConfirmation)),
          content: Text(context.translate(AppStrings.areYouSure)),
          actions: <Widget>[
            TextButton(
              child: Text(context.translate(AppStrings.cancel)),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text(context.translate(AppStrings.exit)),
              onPressed: () {
                context.pop();
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}

extension DateTimeExtensions on DateTime {
  String toReadableDate() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 1) {
      return "$day/$month/$year"; 
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else {
      return "Today";
    }
  }
}
