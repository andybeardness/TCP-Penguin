import 'package:equatable/equatable.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_effect.dart';

class SavedScansScreenBlocState extends Equatable {
  final List<SavedScansScreenBlocStateSavedScanItem> savedScans;
  final SavedScansScreenBlocEffect? effect;

  const SavedScansScreenBlocState({
    required this.savedScans,
    required this.effect,
  });

  factory SavedScansScreenBlocState.initial() =>
      SavedScansScreenBlocState(savedScans: [], effect: null);

  SavedScansScreenBlocState copyWith({
    List<SavedScansScreenBlocStateSavedScanItem>? savedScans,
    SavedScansScreenBlocEffect? effect,
  }) {
    return SavedScansScreenBlocState(
      savedScans: savedScans ?? this.savedScans,
      effect: effect ?? this.effect,
    );
  }

  @override
  List<Object?> get props => [savedScans, effect];
}

class SavedScansScreenBlocStateSavedScanItem extends Equatable {
  final int id;
  final String host;
  final List<int> openPorts;
  final DateTime dateTime;

  const SavedScansScreenBlocStateSavedScanItem({
    required this.id,
    required this.host,
    required this.dateTime,
    required this.openPorts,
  });

  @override
  List<Object?> get props => [id, host, dateTime, openPorts];
}
