import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';

class _HostRepositoryMock extends Mock implements HostRepository {}

class _HostEntityFake implements HostEntity {
  @override
  int id;

  @override
  String host;

  @override
  List<int> openPorts;

  @override
  DateTime createdAt;

  @override
  bool isFavorite;

  _HostEntityFake({
    required this.id,
    required this.host,
    required this.openPorts,
    required this.createdAt,
    required this.isFavorite,
  });
}

void main() {
  late HostRepository hostRepository;
  late BehaviorSubject<List<HostEntity>> hostsSubject;
  late HostSaver hostSaver;

  setUp(() {
    hostRepository = _HostRepositoryMock();
    hostsSubject = BehaviorSubject<List<HostEntity>>.seeded(<HostEntity>[]);
    hostSaver = HostSaver(hostRepository: hostRepository);

    when(() => hostRepository.hosts).thenAnswer((_) => hostsSubject);

    when(
      () => hostRepository.saveHost(
        host: any(named: 'host'),
        openPorts: any(named: 'openPorts'),
        createdAt: any(named: 'createdAt'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => hostRepository.updateHost(
        host: any(named: 'host'),
        openPorts: any(named: 'openPorts'),
      ),
    ).thenAnswer((_) async {});
  });

  tearDown(() async {
    await hostsSubject.close();
  });

  test('Regular first host saved', () async {
    final host = 'example.com';
    final openPorts = [20, 85];
    final createdAt = DateTime.utc(2025, 1, 1, 1, 1, 1);

    await hostSaver.saveHost(
      host: host,
      openPorts: openPorts,
      createdAt: createdAt,
    );

    verify(
      () => hostRepository.saveHost(
        host: host,
        openPorts: openPorts,
        createdAt: createdAt,
      ),
    ).called(1);

    verifyNever(
      () => hostRepository.updateHost(
        host: any(named: 'host'),
        openPorts: any(named: 'openPorts'),
      ),
    );
  });

  test('Regular first host updated', () async {
    final String host = 'example.com';
    final List<int> openPortsOld = [20, 30];
    final List<int> openPortsNew = [20, 30, 40];
    final DateTime createdAt = DateTime.utc(2025, 1, 1, 1, 1, 1);

    hostsSubject.add([
      _HostEntityFake(
        id: 0,
        host: host,
        openPorts: openPortsOld,
        createdAt: createdAt,
        isFavorite: false,
      ),
    ]);

    hostSaver.saveHost(
      host: host,
      openPorts: openPortsNew,
      createdAt: createdAt,
    );

    verifyNever(
      () => hostRepository.saveHost(
        host: any(named: 'host'),
        openPorts: any(named: 'openPorts'),
        createdAt: any(named: 'createdAt'),
      ),
    );

    verify(
      () => hostRepository.updateHost(host: host, openPorts: openPortsNew),
    ).called(1);
  });
}
