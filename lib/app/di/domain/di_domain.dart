import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/domain/concurency_tcp_scanner/concurency_tcp_scanner.dart';
import 'package:tcp_penguin/domain/scans_sharer/scans_sharer.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';

Future<void> setupDomainDI() async {
  getIt.registerLazySingleton<TcpScanner>(() => TcpScanner());

  getIt.registerLazySingleton<ConcurencyTcpScanner>(
    () => ConcurencyTcpScanner(tcpScanner: getIt<TcpScanner>()),
  );

  getIt.registerLazySingleton<HostSaver>(
    () => HostSaver(hostRepository: getIt<HostRepository>()),
  );

  getIt.registerLazySingleton<ScansSharer>(() => ScansSharer());
}
