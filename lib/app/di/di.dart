import 'package:get_it/get_it.dart';
import 'package:tcp_penguin/app/di/data/di_database.dart';
import 'package:tcp_penguin/app/di/data/di_repository.dart';
import 'package:tcp_penguin/app/di/domain/di_domain.dart';
import 'package:tcp_penguin/app/di/presentation/di_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Data
  await setupDatabaseDI();
  await setupRepositoryDI();

  // Domain
  await setupDomainDI();

  // Presentation
  await setupBlocDI();
}
