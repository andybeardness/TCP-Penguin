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
  final String progressSubtitleReady = "Готов к сканированию";

  @override
  String progressSubtitleScanning(String progress) =>
      "Сканирование: $progress%. Не закрывайте приложение!";

  @override
  String get progressSubtitleComplete => "Сканирование завершено";

  @override
  final String outputBlockTitle = "Вывод";

  @override
  String outputHost(String host) => "Хост: $host";

  @override
  String outputOpenPorts(String openPorts) => "Открытые порты: $openPorts";

  @override
  String outputDuration(String timeoutMs) => "Длительность (мс): $timeoutMs";

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
  String openPorts(String openPorts) => "Открытые порты: $openPorts";

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
  final String aboutGithubFirstPart =
      "Не стесняйтесь исследовать исходный код на ";
  @override
  final String aboutGithubSecondPart = " и вносить свой вклад в проект!";
  @override
  final String closeButton = "Закрыть";
}
