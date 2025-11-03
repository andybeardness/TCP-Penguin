import '../app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([super.locale = 'en']);

  @override
  AppLocalizationsHomeScreen homeScreen = _LocalizationHomeScreenEn();

  @override
  AppLocalizationsSavedScansScreen savedScansScreen =
      _LocalizationSavedScansScreenEn();

  @override
  AppLocalizationsDonationDialog donationDialog =
      _LocalizationDonationDialogEn();

  @override
  AppLocalizationsPenguinDialog penguinDialog = _LocalizationPenguinDialogEn();
}

// Home Screen Translations
class _LocalizationHomeScreenEn implements AppLocalizationsHomeScreen {
  @override
  final String warning =
      "⚠️ Scan only systems and networks for which you have explicit written permission. Unauthorized scanning may be illegal and lead to service disruptions.";

  @override
  final String progressBlockTitle = "Progress";

  @override
  String get progressSubtitleReady => "Ready to scan";

  @override
  String progressSubtitleScanning(String progress) =>
      "Scanning: $progress%. Please do not close the app.";

  @override
  String get progressSubtitleComplete => "Scanning complete";

  @override
  final String outputBlockTitle = "Output";

  @override
  String outputHost(String host) => "Host: $host";

  @override
  String outputOpenPorts(String openPorts) => "Open ports: $openPorts";

  @override
  String outputDuration(String durationMs) => "Duration (ms): $durationMs";

  @override
  final String inputBlockTitle = "Input";

  @override
  final String inputHostHint = "Host";

  @override
  final String inputPortStartHint = "Start port [1-…]";

  @override
  final String inputPortEndHint = "End port […-65535]";

  @override
  final String inputWorkersHint = "Workers [1-1000]";

  @override
  final String inputTimeoutHint = "Timeout [10-10000 ms]";

  @override
  final String scanButtonTitleIdle = "Scan";

  @override
  final String scanButtonTitleScanning = "Scanning...";
}

// Saved Scans Screen Translations
class _LocalizationSavedScansScreenEn
    implements AppLocalizationsSavedScansScreen {
  @override
  final String toolbarTitle = "Saved Scans";

  @override
  String openPorts(String openPorts) => "Open ports: $openPorts";

  @override
  String date(String dateTimeFormatted) => "Date: $dateTimeFormatted";
}

// Donation Dialog Translations
class _LocalizationDonationDialogEn implements AppLocalizationsDonationDialog {
  @override
  final String title = "Support Development";

  @override
  final String description =
      "If you enjoy using TCP Penguin, please consider making a donation to support further development and improvement of the app.";
  @override
  final String donateButton = "☕️ Donate";
  @override
  final String cancelButton = "Cancel";
}

// Penguin Dialog Translations
class _LocalizationPenguinDialogEn implements AppLocalizationsPenguinDialog {
  @override
  final String developedBy = "Developed by Andy Beardness";
  @override
  final String aboutApp =
      "TCP Penguin is an open-source project aimed at providing a simple and effective TCP port scanning solution for network administrators and security professionals.";
  @override
  final String aboutGithubFirstPart =
      "Feel free to explore the source code on ";
  @override
  final String aboutGithubSecondPart = " and contribute to the project!";
  @override
  final String closeButton = "Close";
}
