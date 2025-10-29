sealed class HomeScreenAction {}

class HomeScreenActionFirstOpenScreen extends HomeScreenAction {}

class HomeScreenActionOnClickSavedScans extends HomeScreenAction {}

class HomeScreenActionOnClickDonation extends HomeScreenAction {}

class HomeScreenActionUpdateHost extends HomeScreenAction {
  final String newHost;

  HomeScreenActionUpdateHost({required this.newHost});
}

class HomeScreenActionUpdateStartPort extends HomeScreenAction {
  final int newStartPort;

  HomeScreenActionUpdateStartPort({required this.newStartPort});
}

class HomeScreenActionUpdateEndPort extends HomeScreenAction {
  final int newEndPort;

  HomeScreenActionUpdateEndPort({required this.newEndPort});
}

class HomeScreenActionUpdateMaxWorkers extends HomeScreenAction {
  final int newMaxWorkers;

  HomeScreenActionUpdateMaxWorkers({required this.newMaxWorkers});
}

class HomeScreenActionUpdateTimeout extends HomeScreenAction {
  final int newTimeoutMs;

  HomeScreenActionUpdateTimeout({required this.newTimeoutMs});
}

class HomeScreenActionOnClickScanButton extends HomeScreenAction {}
