import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/domain/scans_sharer/scans_sharer.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_effect.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_event.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_state.dart';

class SavedScansScreenBloc
    extends Bloc<SavedScansScreenBlocEvent, SavedScansScreenBlocState> {
  final HostRepository hostRepository;
  final ScansSharer scansSharer;

  late final StreamSubscription<List<HostEntity>> _hostsSubscription;

  SavedScansScreenBloc({
    required this.hostRepository,
    required this.scansSharer,
  }) : super(SavedScansScreenBlocState.initial()) {
    _hostsSubscription = hostRepository.hosts.listen((hosts) {
      final savedScans = hosts
          .map(
            (host) => SavedScansScreenBlocStateSavedScanItem(
              id: host.id,
              host: host.host,
              openPorts: host.openPorts,
              dateTime: host.createdAt,
            ),
          )
          .toList();

      add(SavedScansScreenBlocEventUpdateSavedScans(savedScans: savedScans));
    });

    on<SavedScansScreenBlocEventUpdateSavedScans>(
      (event, emit) => emit(state.copyWith(savedScans: event.savedScans)),
    );

    on<SavedScansScreenBlocEventOnClickDeleteScan>((event, emit) async {
      await hostRepository.deleteHost(id: event.id);
    });

    on<SavedScansScreenBlocEventOnClickNavigateBack>(
      (event, emit) => emit(
        state.copyWith(effect: SavedScansScreenBlocEffectNavigateBack()),
      ),
    );

    on<SavedScansScreenBlocEventOnClickShare>((event, emit) async {
      final scanItems = state.savedScans
          .map(
            (savedScan) => ScanItem(
              host: savedScan.host,
              openPorts: savedScan.openPorts,
              dateTime: savedScan.dateTime,
            ),
          )
          .toList();

      await scansSharer.saveScansAsCsv(scans: scanItems);
    });

    on<InternalSavedScansScreenBlocEventClearEffect>(
      (event, emit) => emit(state.copyWith(effect: null)),
    );
  }

  @override
  Future<void> close() {
    _hostsSubscription.cancel();
    return super.close();
  }
}
