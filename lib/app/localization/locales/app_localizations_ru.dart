import '../app_localizations.dart';

class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([super.locale = 'ru']);

  @override
  AppLocalizationsHomeScreen homeScreen = _LocalizationHomeScreenRu();

  @override
  AppLocalizationsSavedScansScreen savedScansScreen =
      _LocalizationSavedScansScreenRu();

  @override
  AppLocalizationsDonationDialog donationDialog =
      _LocalizationDonationDialogRu();

  @override
  AppLocalizationsPenguinDialog penguinDialog = _LocalizationPenguinDialogRu();
}

// Home Screen Translations
class _LocalizationHomeScreenRu implements AppLocalizationsHomeScreen {
  @override
  final String warning =
      "⚠️ Сканируйте только те системы и сети, на которые у вас есть явное письменное разрешение. Несанкционированное сканирование может быть незаконным и привести к сбоям в работе служб.";

  @override
  final String progressBlockTitle = "Прогресс";

  @override
  String progressSubtitle(double progress) {
    if (progress == 0) {
      return "Готов к сканированию";
    } else if (progress > 0 && progress < 1) {
      return "Сканирование: ${(progress * 100).toStringAsFixed(1)}%. Не закрывайте приложение!";
    } else if (progress >= 1) {
      return "Сканирование завершено";
    }
    return "";
  }

  @override
  final String outputBlockTitle = "Вывод";

  @override
  String outputHost(String host) => host.isEmpty ? "Хост: –" : "Хост: $host";

  @override
  String outputOpenPorts(List<int> openPorts) => openPorts.isEmpty
      ? "Открытые порты: –"
      : "Открытые порты: ${openPorts.join(', ')}";

  @override
  String outputDuration(int ms) =>
      ms >= 0 ? "Длительность (мс): $ms" : "Длительность (мс): –";

  @override
  final String inputBlockTitle = "Ввод";

  @override
  final String inputHostHint = "Хост";

  @override
  final String inputPortStartHint = "Начальный порт [1-…]";

  @override
  final String inputPortEndHint = "Конечный порт […-65535]";

  @override
  final String inputWorkersHint = "Воркеры [1-1000]";

  @override
  final String inputTimeoutHint = "Таймаут [10-10000 мс]";

  @override
  final String scanButtonTitleIdle = "Сканировать";

  @override
  final String scanButtonTitleScanning = "Сканирование...";
}

class _LocalizationSavedScansScreenRu
    implements AppLocalizationsSavedScansScreen {
  @override
  final String toolbarTitle = "Сохранённые сканы";

  @override
  String openPorts(List<int> openPorts) => openPorts.isEmpty
      ? "Открытые порты: –"
      : "Открытые порты: ${openPorts.join(', ')}";

  @override
  String date(String dateTimeFormatted) => "Дата: $dateTimeFormatted";
}

// Donation Dialog Translations
class _LocalizationDonationDialogRu implements AppLocalizationsDonationDialog {
  @override
  final String title = "Поддержите TCP Penguin";
  @override
  final String description =
      "Если вам нравится использовать TCP Penguin, пожалуйста, рассмотрите возможность сделать пожертвование, чтобы поддержать дальнейшую разработку и улучшение приложения.";
  @override
  final String donateButton = "☕️ Пожертвовать";
  @override
  final String cancelButton = "Отмена";
}

// Penguin Dialog Translations
class _LocalizationPenguinDialogRu implements AppLocalizationsPenguinDialog {
  @override
  final String developedBy = "Разработано Andy Beardness";
  @override
  final String aboutApp =
      "TCP Penguin - это проект с открытым исходным кодом, целью которого является предоставление простого и эффективного решения для сканирования TCP-портов для сетевых администраторов и специалистов по безопасности.";
  @override
  final String aboutGithub =
      "Не стесняйтесь исследовать исходный код на GitHub и вносить свой вклад в проект!";
  @override
  final String closeButton = "Закрыть";
}
