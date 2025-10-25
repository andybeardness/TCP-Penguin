import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/domain/concurency_runner/concurency_runner.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';

Future<void> setupDomainDI() async {
  getIt.registerLazySingleton<TcpScanner>(() => TcpScanner());

  getIt.registerLazySingleton<ConcurencyRunner>(
    () => ConcurencyRunner(tcpScanner: getIt<TcpScanner>()),
  );

  getIt.registerLazySingleton<HostSaver>(
    () => HostSaver(hostRepository: getIt<HostRepository>()),
  );
}
