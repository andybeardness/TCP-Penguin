import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_state.dart';

sealed class SavedScansScreenBlocEvent {}

class SavedScansScreenBlocEventUpdateSavedScans
    extends SavedScansScreenBlocEvent {
  final List<SavedScansScreenBlocStateSavedScanItem> savedScans;

  SavedScansScreenBlocEventUpdateSavedScans({required this.savedScans});
}

class SavedScansScreenBlocEventOnClickDeleteScan
    extends SavedScansScreenBlocEvent {
  final int id;

  SavedScansScreenBlocEventOnClickDeleteScan({required this.id});
}

class SavedScansScreenBlocEventOnClickNavigateBack
    extends SavedScansScreenBlocEvent {}

class InternalSavedScansScreenBlocEventClearEffect
    extends SavedScansScreenBlocEvent {}
