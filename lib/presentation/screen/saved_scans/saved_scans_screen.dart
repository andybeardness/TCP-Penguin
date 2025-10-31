import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_bloc.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_body.dart';

class SavedScansScreen extends StatelessWidget {
  const SavedScansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SavedScansScreenBloc>(),
      child: SavedScansScreenBody(),
    );
  }
}
