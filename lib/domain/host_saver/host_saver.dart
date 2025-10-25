import 'package:tcp_penguin/data/repository/host/host_repository.dart';

class HostSaver {
  final HostRepository hostRepository;

  HostSaver({required this.hostRepository});

  Future<void> saveHost({
    required String host,
    required List<int> openPorts,
    required DateTime createdAt,
  }) async {
    final hosts = hostRepository.hosts.value;

    final existingHost = hosts
        .where((entity) => entity.host == host)
        .firstOrNull;

    if (existingHost == null) {
      await hostRepository.saveHost(
        host: host,
        openPorts: openPorts,
        createdAt: createdAt,
      );
    }
  }
}
