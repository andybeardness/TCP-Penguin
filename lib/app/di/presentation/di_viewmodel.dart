import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/domain/concurency_runner/concurency_runner.dart';
import 'package:tcp_penguin/domain/host_saver/host_saver.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_view_model.dart';

Future<void> setupViewModelDI() async {
  getIt.registerFactory<HomeScreenViewModel>(
    () => HomeScreenViewModel(
      tcpScanner: getIt<TcpScanner>(),
      concurencyRunner: getIt<ConcurencyRunner>(),
      hostSaver: getIt<HostSaver>(),
    ),
  );
}
