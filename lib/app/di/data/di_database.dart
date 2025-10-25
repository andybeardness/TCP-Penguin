import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';

Future<void> setupDatabaseDI() async {
  final dir = await getApplicationDocumentsDirectory();
  final schemas = [HostEntitySchema];
  final isar = await Isar.open(schemas, directory: dir.path);
  getIt.registerLazySingleton<Isar>(() => isar);
}
