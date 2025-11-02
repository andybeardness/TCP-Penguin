import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';

class HostRepository {
  final Isar isar;

  BehaviorSubject<List<HostEntity>> hosts = BehaviorSubject.seeded([]);

  HostRepository({required this.isar}) {
    isar.hostEntitys.watchLazy(fireImmediately: true).listen((_) async {
      final savedHosts = await isar.hostEntitys.where().findAll();
      hosts.add(savedHosts);
    });
  }

  Future<void> saveHost({
    required String host,
    required List<int> openPorts,
    required DateTime createdAt,
  }) async {
    final hostEntity = HostEntity()
      ..host = host
      ..openPorts = openPorts
      ..createdAt = createdAt;

    await isar.writeTxn(() async {
      await isar.hostEntitys.put(hostEntity);
    });
  }

  Future<void> deleteHost({required int id}) async {
    await isar.writeTxn(() async {
      await isar.hostEntitys.delete(id);
    });
  }

  Future<void> updateHost({
    required String host,
    required List<int> openPorts,
  }) async {
    final existingHost = await isar.hostEntitys
        .where()
        .filter()
        .hostEqualTo(host)
        .findFirst();

    if (existingHost != null) {
      existingHost.openPorts = openPorts;

      await isar.writeTxn(() async {
        await isar.hostEntitys.put(existingHost);
      });
    }
  }
}
