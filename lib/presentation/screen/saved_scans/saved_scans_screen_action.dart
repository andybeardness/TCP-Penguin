sealed class SavedScansScreenAction {}

class SavedScansScreenActionOnClickNavigateBack
    extends SavedScansScreenAction {}

class SavedScansScreenActionOnClickDeleteSavedScan
    extends SavedScansScreenAction {
  final int id;

  SavedScansScreenActionOnClickDeleteSavedScan({required this.id});
}
