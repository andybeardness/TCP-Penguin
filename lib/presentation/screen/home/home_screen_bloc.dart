import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp_penguin/domain/concurency_tcp_scanner/concurency_tcp_scanner.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_effect.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_event.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenBlocEvent, HomeScreenBlocState> {
  final TcpScanner tcpScanner;
  final ConcurencyTcpScanner concurencyTcpScanner;
  final HostSaver hostSaver;

  DateTime? _lastProgressEmit;

  HomeScreenBloc({
    required this.tcpScanner,
    required this.concurencyTcpScanner,
    required this.hostSaver,
  }) : super(HomeScreenBlocState.initial()) {
    on<HomeScreenBlocEventInitial>(
      (e, emit) => emit(
        state.copyWith(effect: HomeScreenBlocEffectShowDonationDialog()),
      ),
    );

    on<HomeScreenBlocEventClickLogo>(
      (e, emit) =>
          emit(state.copyWith(effect: HomeScreenBlocEffectShowPenguinDialog())),
    );

    on<HomeScreenBlocEventClickDonate>(
      (e, emit) => emit(
        state.copyWith(effect: HomeScreenBlocEffectShowDonationDialog()),
      ),
    );

    on<HomeScreenBlocEventClickSavedScans>(
      (e, emit) => emit(
        state.copyWith(effect: HomeScreenBlocEffectNavigateToSavedScans()),
      ),
    );

    on<HomeScreenBlocEventUpdateHost>((e, emit) {
      final trimmedHost = e.host.trim();

      if (trimmedHost.isEmpty) {
        emit(
          state.copyWith(
            formHost: trimmedHost,
            formHostError: () => 'Host cannot be empty',
          ),
        );
        return;
      }

      emit(state.copyWith(formHost: trimmedHost, formHostError: () => null));
    });

    on<HomeScreenBlocEventUpdateStartPort>((e, emit) {
      if (e.port.isEmpty) {
        emit(
          state.copyWith(
            formPortStart: int.tryParse(e.port),
            formPortStartError: () => 'Port Start cannot be empty',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          formPortStart: int.tryParse(e.port),
          formPortStartError: () => null,
        ),
      );
    });

    on<HomeScreenBlocEventUpdateEndPort>((e, emit) {
      if (e.port.isEmpty) {
        emit(
          state.copyWith(
            formPortEnd: int.tryParse(e.port),
            formPortEndError: () => 'Port End cannot be empty',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          formPortEnd: int.tryParse(e.port),
          formPortEndError: () => null,
        ),
      );
    });

    on<HomeScreenBlocEventUpdateWorkers>((e, emit) {
      final intWorkers = int.tryParse(e.workers);

      if (e.workers.isEmpty) {
        emit(
          state.copyWith(
            formWorkers: intWorkers,
            formWorkersError: () => 'Workers cannot be empty',
          ),
        );
        return;
      }

      emit(
        state.copyWith(formWorkers: intWorkers, formWorkersError: () => null),
      );
    });

    on<HomeScreenBlocEventUpdateTimeout>((e, emit) {
      final intTimeout = int.tryParse(e.timeoutMs);

      if (e.timeoutMs.isEmpty) {
        emit(
          state.copyWith(
            formTimeout: intTimeout,
            formTimeoutError: () => 'Timeout cannot be empty',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          formTimeout: int.tryParse(e.timeoutMs),
          formTimeoutError: () => null,
        ),
      );
    });

    on<HomeScreenBlocEventClickScan>((e, emit) async {
      emit(state.copyWith(isLoading: true, progress: 0.0));

      final scanStartTime = DateTime.now();

      final openPorts = await concurencyTcpScanner.runConcurrently(
        host: state.formHost,
        portStart: state.formPortStart,
        portEnd: state.formPortEnd,
        maxConcurrent: state.formWorkers,
        timeoutMs: state.formTimeout,
        onProgress: (double progress) {
          final now = DateTime.now();

          if (progress <= 0) {
            emit(state.copyWith(progress: 0));
          } else if (progress >= 1) {
            emit(state.copyWith(progress: 1));
          } else {
            if (_lastProgressEmit == null ||
                now.difference(_lastProgressEmit!) >
                    const Duration(milliseconds: 120)) {
              _lastProgressEmit = now;
              emit(state.copyWith(progress: progress));
            }
          }
        },
      );

      final scanEndTime = DateTime.now();

      final scanDuration = scanEndTime.difference(scanStartTime).inMilliseconds;

      emit(
        state.copyWith(
          isLoading: false,
          progress: 1,
          scanResultHost: state.formHost,
          scanResultOpenPorts: openPorts,
          scanResultDuration: scanDuration,
        ),
      );

      if (openPorts.isNotEmpty) {
        await hostSaver.saveHost(
          host: state.formHost,
          openPorts: openPorts,
          createdAt: DateTime.now(),
        );
      }
    });

    on<InternalHomeScreenBlocEventClearEffect>(
      (e, emit) => emit(state.copyWith(effect: null)),
    );
  }
}
