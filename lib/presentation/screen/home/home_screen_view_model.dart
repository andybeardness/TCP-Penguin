import 'package:rxdart/rxdart.dart';
import 'package:tcp_penguin/domain/concurency_runner/concurency_runner.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';
import 'package:tcp_penguin/presentation/common_dialog/donation/common_dialog_donation.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_action.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_event.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_form.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_scan_result.dart';

class OpenPortsResult {
  final String host;
  final List<int> openPorts;

  OpenPortsResult({required this.host, required this.openPorts});
}

class HomeScreenViewModel {
  final TcpScanner tcpScanner;
  final ConcurencyRunner concurencyRunner;
  final HostSaver hostSaver;

  final BehaviorSubject<double?> _progress = BehaviorSubject.seeded(null);
  ValueStream<double?> get progress$ => _progress.stream;

  final BehaviorSubject<HomeScreenViewScanResultEntity?> _scanResult =
      BehaviorSubject.seeded(null);
  ValueStream<HomeScreenViewScanResultEntity?> get scanResult$ =>
      _scanResult.stream;

  final BehaviorSubject<HomeScreenViewFormEntity> _form =
      BehaviorSubject.seeded(
        HomeScreenViewFormEntity(
          host: "scanme.nmap.org",
          portStart: 1,
          portEnd: 255,
          workers: 100,
          timeout: 5000,
        ),
      );
  ValueStream<HomeScreenViewFormEntity> get form$ => _form.stream;

  final BehaviorSubject<HomeScreenEvent> event = BehaviorSubject();

  HomeScreenViewModel({
    required this.tcpScanner,
    required this.concurencyRunner,
    required this.hostSaver,
  });

  void dispose() {
    event.close();
    _progress.close();
    _scanResult.close();
    _form.close();
  }

  Future<void> handleAction({required HomeScreenAction action}) async {
    if (action is HomeScreenActionFirstOpenScreen) {
      event.add(
        HomeScreenEventShowDonateDialog(entity: _buildDonationDialogEntity()),
      );
    } else if (action is HomeScreenActionOnClickDonation) {
      event.add(
        HomeScreenEventShowDonateDialog(entity: _buildDonationDialogEntity()),
      );
    } else if (action is HomeScreenActionOnClickSavedScans) {
      event.add(HomeScreenEventNavigateToSavedScans());
    } else if (action is HomeScreenActionUpdateHost) {
      _form.add(_form.value.copyWith(host: action.newHost));
    } else if (action is HomeScreenActionUpdateStartPort) {
      _form.add(_form.value.copyWith(portStart: action.newStartPort));
    } else if (action is HomeScreenActionUpdateEndPort) {
      _form.add(_form.value.copyWith(portEnd: action.newEndPort));
    } else if (action is HomeScreenActionUpdateMaxWorkers) {
      _form.add(_form.value.copyWith(workers: action.newMaxWorkers));
    } else if (action is HomeScreenActionUpdateTimeout) {
      _form.add(_form.value.copyWith(timeout: action.newTimeoutMs));
    } else if (action is HomeScreenActionOnClickScanButton) {
      _progress.add(0);

      final openPorts = await concurencyRunner.runConcurrently(
        host: _form.value.host,
        portStart: _form.value.portStart,
        portEnd: _form.value.portEnd,
        maxConcurrent: _form.value.workers,
        onProgress: (progress) {
          _progress.add(progress);
        },
      );

      if (openPorts.isNotEmpty) {
        _scanResult.add(
          HomeScreenViewScanResultEntity(
            host: _form.value.host,
            openPorts: openPorts,
          ),
        );

        await hostSaver.saveHost(
          host: _form.value.host,
          openPorts: openPorts,
          createdAt: DateTime.now(),
        );
      }

      _progress.add(1);
    }
  }

  CommonDialogDonationEntity _buildDonationDialogEntity() {
    return CommonDialogDonationEntity(
      title: "Support the Developer",
      subtitle:
          "If you enjoy using this app, you can support the developer by making a donation",
      cancelText: "Later",
      confirmText: "☕️ Donate",
      confirmUrl: "https://ko-fi.com/andybeardness",
    );
  }
}
