import '../app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([super.locale = 'en']);

  @override
  AppLocalizationsHomeScreen get homeScreen => _LocalizationHomeScreenEn();
}

// Home Screen Translations
class _LocalizationHomeScreenEn implements AppLocalizationsHomeScreen {
  @override
  final String warning =
      "⚠️ Scan only systems and networks for which you have explicit written permission. Unauthorized scanning may be illegal and lead to service disruptions.";

  @override
  final String progressBlockTitle = "Progress";

  @override
  String progressSubtitle(double progress) {
    if (progress == 0) {
      return "Ready to scan";
    } else if (progress > 0 && progress < 1) {
      return "Scanning: ${(progress * 100).toStringAsFixed(1)}%. Please do not close the app.";
    } else if (progress >= 1) {
      return "Scanning complete";
    }
    return "";
  }

  @override
  final String outputBlockTitle = "Output";

  @override
  String outputHost(String host) => "Host: $host";

  @override
  String outputOpenPorts(List<int> openPorts) => openPorts.isEmpty
      ? "Open ports: not found"
      : "Open ports: ${openPorts.join(', ')}";

  @override
  String outputDuration(int ms) => "Duration (ms): $ms";

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
