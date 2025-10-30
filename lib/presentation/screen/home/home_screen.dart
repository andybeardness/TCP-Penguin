import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_event.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeScreenBloc>()..add(HomeScreenBlocEventInitial()),
      child: const HomeScreenBody(),
    );
  }
}
