import 'package:flutter/material.dart' show Locale, LocalizationsDelegate;
import 'lang_keys.dart';

import 'app_localization.dart';

// Defining a custom LocalizationsDelegate for AppLocalizations.
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  // Override method to check if a given locale is supported by the app.
  @override
  bool isSupported(Locale locale) {
    return [LangKeys.englishCode, LangKeys.arabicCode]
        .contains(locale.languageCode);
  }

  // Override method to load the AppLocalizations for a given locale.
  @override
  Future<AppLocalizations> load(Locale locale) async {
    final appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  // Override method to determine whether the localization should be reloaded.
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
