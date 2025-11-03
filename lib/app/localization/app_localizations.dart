import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'locales/app_localizations_en.dart';
import 'locales/app_localizations_ru.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        _AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  AppLocalizationsHomeScreen get homeScreen;
  AppLocalizationsSavedScansScreen get savedScansScreen;
  AppLocalizationsDonationDialog get donationDialog;
  AppLocalizationsPenguinDialog get penguinDialog;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale".',
  );
}

abstract class AppLocalizationsHomeScreen {
  String get warning;
  String get progressBlockTitle;
  String progressSubtitle(double progress);
  String get outputBlockTitle;
  String outputHost(String host);
  String outputOpenPorts(List<int> openPorts);
  String outputDuration(int ms);
  String get inputBlockTitle;
  String get inputHostHint;
  String get inputPortStartHint;
  String get inputPortEndHint;
  String get inputWorkersHint;
  String get inputTimeoutHint;
  String get scanButtonTitleIdle;
  String get scanButtonTitleScanning;
}

abstract class AppLocalizationsSavedScansScreen {
  String get toolbarTitle;
  String openPorts(List<int> openPorts);
  String date(String dateTimeFormatted);
}

abstract class AppLocalizationsDonationDialog {
  String get title;
  String get description;
  String get donateButton;
  String get cancelButton;
}

abstract class AppLocalizationsPenguinDialog {
  String get developedBy;
  String get aboutApp;
  String get aboutGithub;
  String get closeButton;
}
