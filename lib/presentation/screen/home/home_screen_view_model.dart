import 'package:rxdart/rxdart.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/domain/concurency_runner/concurency_runner.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';
import 'package:tcp_penguin/presentation/common_view/spacer/common_view_spacer.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_action.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_state.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_host.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_saved_hosts.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_workers.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_port_range.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_scan_button.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_timeout.dart';

class HomeScreenViewModel {
  final TcpScanner tcpScanner;
  final ConcurencyRunner concurencyRunner;
  final HostRepository hostRepository;
  final HostSaver hostSaver;

  final BehaviorSubject<HomeScreenState> state = BehaviorSubject.seeded(
    HomeScreenState(viewItems: []),
  );

  final BehaviorSubject<String> _host = BehaviorSubject.seeded(
    "scanme.nmap.org",
  );
  final BehaviorSubject<String> _startPort = BehaviorSubject.seeded('1');
  final BehaviorSubject<String> _endPort = BehaviorSubject.seeded('255');
  final BehaviorSubject<String> _workers = BehaviorSubject.seeded('100');
  final BehaviorSubject<String> _timeoutMs = BehaviorSubject.seeded('5000');

  final BehaviorSubject<bool> _isScanning = BehaviorSubject.seeded(false);

  HomeScreenViewModel({
    required this.tcpScanner,
    required this.concurencyRunner,
    required this.hostRepository,
    required this.hostSaver,
  }) {
    Rx.combineLatest(
      [
        _host,
        _startPort,
        _endPort,
        _workers,
        _timeoutMs,
        _isScanning,
        hostRepository.hosts,
      ],
      (streams) async {
        final String host = streams[0] as String;
        final String startPort = streams[1] as String;
        final String endPort = streams[2] as String;
        final String maxWorkers = streams[3] as String;
        final String timeoutMs = streams[4] as String;
        final bool isScanning = streams[5] as bool;
        final List<HostEntity> savedHosts = streams[6] as List<HostEntity>;

        final viewItems = <HomeScreenStateViewItem>[];

        bool hasErrors = false;

        viewItems.add(
          HomeScreenStateViewItemSpacer(
            entity: CommonViewSpacerEntity(height: 16),
          ),
        );

        String? hostErrorText;
        if (host.isEmpty) {
          hostErrorText = "Empty host";
          hasErrors = true;
        }

        viewItems.add(
          HomeScreenStateViewItemHost(
            entity: HomeScreenViewHostEntity(
              host: host,
              errorText: hostErrorText,
            ),
          ),
        );

        viewItems.add(
          HomeScreenStateViewItemSpacer(
            entity: CommonViewSpacerEntity(height: 8),
          ),
        );

        String? startPortErrorText;
        if (startPort.isEmpty) {
          startPortErrorText = "Start port is empty";
          hasErrors = true;
        }

        String? endPortErrorText;
        if (endPort.isEmpty) {
          endPortErrorText = "End port is empty";
          hasErrors = true;
        }

        viewItems.add(
          HomeScreenStateViewItemPortRange(
            entity: HomeScreenViewPortRangeEntity(
              startPort: startPort,
              startPortErrorText: startPortErrorText,
              endPort: endPort,
              endPortErrorText: endPortErrorText,
            ),
          ),
        );

        viewItems.add(
          HomeScreenStateViewItemSpacer(
            entity: CommonViewSpacerEntity(height: 8),
          ),
        );

        String? workersErrorText;
        if (maxWorkers.isEmpty) {
          workersErrorText = "Max workers is empty";
          hasErrors = true;
        }

        viewItems.add(
          HomeScreenStateViewItemMaxWorkers(
            entity: HomeScreenViewWorkersEntity(
              maxWorkers: maxWorkers,
              errorText: workersErrorText,
            ),
          ),
        );

        viewItems.add(
          HomeScreenStateViewItemSpacer(
            entity: CommonViewSpacerEntity(height: 8),
          ),
        );

        String? timeoutErrorText;
        if (timeoutMs.isEmpty) {
          timeoutErrorText = "Timeout is empty";
          hasErrors = true;
        }

        viewItems.add(
          HomeScreenStateViewItemTimeout(
            entity: HomeScreenViewTimeoutEntity(
              timeoutMs: timeoutMs,
              errorText: timeoutErrorText,
            ),
          ),
        );

        viewItems.add(
          HomeScreenStateViewItemSpacer(
            entity: CommonViewSpacerEntity(height: 8),
          ),
        );

        if (savedHosts.isNotEmpty) {
          viewItems.add(
            HomeScreenStateViewItemSavedHosts(
              entity: HomeScreenViewSavedHostsEntity(hosts: savedHosts),
            ),
          );

          viewItems.add(
            HomeScreenStateViewItemSpacer(
              entity: CommonViewSpacerEntity(height: 8),
            ),
          );
        }

        viewItems.add(
          HomeScreenStateViewItemScanButton(
            entity: HomeScreenViewScanButtonEntity(
              label: 'Start Scan TCP',
              isEnabled: !hasErrors && !isScanning,
            ),
          ),
        );

        return HomeScreenState(viewItems: viewItems);
      },
    ).listen((newState) async {
      state.add(await newState);
    });
  }

  void dispose() {
    state.close();
    _host.close();
    _startPort.close();
    _endPort.close();
    _workers.close();
    _timeoutMs.close();
    _isScanning.close();
  }

  Future<void> handleAction({required HomeScreenAction action}) async {
    if (action is HomeScreenActionUpdateHost) {
      _host.add(action.newHost);
    } else if (action is HomeScreenActionUpdateStartPort) {
      _startPort.add(action.newStartPort);
    } else if (action is HomeScreenActionUpdateEndPort) {
      _endPort.add(action.newEndPort);
    } else if (action is HomeScreenActionUpdateMaxWorkers) {
      _workers.add(action.newMaxWorkers);
    } else if (action is HomeScreenActionUpdateTimeout) {
      _timeoutMs.add(action.newTimeoutMs);
    } else if (action is HomeScreenActionOnClickScanButton) {
      final String host = _host.value;
      final int startPort = int.tryParse(_startPort.value) ?? 1;
      final int endPort = int.tryParse(_endPort.value) ?? 255;
      final int maxWorkers = int.tryParse(_workers.value) ?? 100;

      _isScanning.add(true);

      final openPorts = await concurencyRunner.runConcurrently(
        host: host,
        portStart: startPort,
        portEnd: endPort,
        maxConcurrent: maxWorkers,
      );

      if (openPorts.isNotEmpty) {
        await hostSaver.saveHost(
          host: host,
          openPorts: openPorts,
          createdAt: DateTime.now(),
        );
      }

      _isScanning.add(false);
    }
  }
}
