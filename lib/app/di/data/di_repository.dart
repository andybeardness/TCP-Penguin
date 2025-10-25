import 'package:isar/isar.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';

Future<void> setupRepositoryDI() async {
  getIt.registerLazySingleton<HostRepository>(
    () => HostRepository(isar: getIt<Isar>()),
  );
}
