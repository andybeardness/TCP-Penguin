import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_view_model.dart';

Future<void> setupViewModelDI() async {
  getIt.registerFactory<SavedScansScreenViewModel>(
    () => SavedScansScreenViewModel(hostRepository: getIt<HostRepository>()),
  );
}
