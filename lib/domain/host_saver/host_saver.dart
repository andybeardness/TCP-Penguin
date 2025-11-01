import 'package:tcp_penguin/data/repository/host/host_repository.dart';

class HostSaver {
  final HostRepository hostRepository;

  HostSaver({required this.hostRepository});

  Future<void> saveHost({
    required String host,
    required List<int> openPorts,
    required DateTime createdAt,
  }) async {
    final formattedHost = host.trim().toLowerCase();

    final hosts = hostRepository.hosts.value;

    final existingHost = hosts
        .where((entity) => entity.host == formattedHost)
        .firstOrNull;

    if (existingHost == null) {
      await hostRepository.saveHost(
        host: formattedHost,
        openPorts: openPorts,
        createdAt: createdAt,
      );
    } else {
      await hostRepository.updateHost(
        host: formattedHost,
        openPorts: openPorts,
      );
    }
  }
}
