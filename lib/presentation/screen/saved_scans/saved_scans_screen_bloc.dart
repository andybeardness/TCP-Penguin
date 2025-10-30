import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_effect.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_event.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc_state.dart';

class SavedScansScreenBloc
    extends Bloc<SavedScansScreenBlocEvent, SavedScansScreenBlocState> {
  final HostRepository hostRepository;

  late final StreamSubscription<List<HostEntity>> _hostsSubscription;

  SavedScansScreenBloc({required this.hostRepository})
    : super(SavedScansScreenBlocState.initial()) {
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
