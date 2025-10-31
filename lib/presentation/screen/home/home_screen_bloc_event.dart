sealed class HomeScreenBlocEvent {}

class HomeScreenBlocEventInitial extends HomeScreenBlocEvent {}

class HomeScreenBlocEventClickLogo extends HomeScreenBlocEvent {}

class HomeScreenBlocEventClickDonate extends HomeScreenBlocEvent {}

class HomeScreenBlocEventClickSavedScans extends HomeScreenBlocEvent {}

class HomeScreenBlocEventUpdateHost extends HomeScreenBlocEvent {
  final String host;
  HomeScreenBlocEventUpdateHost({required this.host});
}

class HomeScreenBlocEventUpdateStartPort extends HomeScreenBlocEvent {
  final String port;
  HomeScreenBlocEventUpdateStartPort({required this.port});
}

class HomeScreenBlocEventUpdateEndPort extends HomeScreenBlocEvent {
  final String port;
  HomeScreenBlocEventUpdateEndPort({required this.port});
}

class HomeScreenBlocEventUpdateWorkers extends HomeScreenBlocEvent {
  final String workers;
  HomeScreenBlocEventUpdateWorkers({required this.workers});
}

class HomeScreenBlocEventUpdateTimeout extends HomeScreenBlocEvent {
  final String timeoutMs;
  HomeScreenBlocEventUpdateTimeout({required this.timeoutMs});
}

class HomeScreenBlocEventClickScan extends HomeScreenBlocEvent {}

class InternalHomeScreenBlocEventClearEffect extends HomeScreenBlocEvent {}
