import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/domain/concurency_runner/concurency_runner.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc.dart';

Future<void> setupBlocDI() async {
  getIt.registerFactory<HomeScreenBloc>(
    () => HomeScreenBloc(
      tcpScanner: getIt<TcpScanner>(),
      concurencyRunner: getIt<ConcurencyRunner>(),
      hostSaver: getIt<HostSaver>(),
    ),
  );

  getIt.registerFactory<SavedScansScreenBloc>(
    () => SavedScansScreenBloc(hostRepository: getIt<HostRepository>()),
  );
}
