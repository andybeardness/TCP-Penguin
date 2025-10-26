sealed class HomeScreenAction {}

class HomeScreenActionOnClickSavedScans extends HomeScreenAction {}

class HomeScreenActionUpdateHost extends HomeScreenAction {
  final String newHost;

  HomeScreenActionUpdateHost({required this.newHost});
}

class HomeScreenActionUpdateStartPort extends HomeScreenAction {
  final String newStartPort;

  HomeScreenActionUpdateStartPort({required this.newStartPort});
}

class HomeScreenActionUpdateEndPort extends HomeScreenAction {
  final String newEndPort;

  HomeScreenActionUpdateEndPort({required this.newEndPort});
}

class HomeScreenActionUpdateMaxWorkers extends HomeScreenAction {
  final String newMaxWorkers;

  HomeScreenActionUpdateMaxWorkers({required this.newMaxWorkers});
}

class HomeScreenActionUpdateTimeout extends HomeScreenAction {
  final String newTimeoutMs;

  HomeScreenActionUpdateTimeout({required this.newTimeoutMs});
}

class HomeScreenActionOnClickScanButton extends HomeScreenAction {}
