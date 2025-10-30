import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp_penguin/presentation/common_dialog/donation/common_dialog_donation.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_effect.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_event.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_state.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final textControllerHost = TextEditingController();
  final textControllerPortStart = TextEditingController();
  final textControllerPortEnd = TextEditingController();
  final textControllerWorkers = TextEditingController();
  final textControllerTimeout = TextEditingController();

  @override
  void initState() {
    super.initState();

    final state = context.read<HomeScreenBloc>().state;
    textControllerHost.text = state.formHost;
    textControllerPortStart.text = state.formPortStart.toString();
    textControllerPortEnd.text = state.formPortEnd.toString();
    textControllerWorkers.text = state.formWorkers.toString();
    textControllerTimeout.text = state.formTimeout.toString();
  }

  @override
  void dispose() {
    textControllerHost.dispose();
    textControllerPortStart.dispose();
    textControllerPortEnd.dispose();
    textControllerWorkers.dispose();
    textControllerTimeout.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenBlocState>(
      listenWhen: (prev, curr) => prev.effect != curr.effect,
      listener: (context, state) {
        final effect = state.effect;
        if (effect == null) return;

        final bloc = context.read<HomeScreenBloc>();

        switch (effect) {
          case HomeScreenBlocEffectShowDonationDialog():
            CommonDialogDonation.show(
              context: context,
              entity: effect.entity,
              onCancel: () => context.pop(),
              onConfirm: () => context.pop(),
            );
            break;
          case HomeScreenBlocEffectNavigateToSavedScans():
            context.push('/saved_scans');
            break;
        }

        bloc.add(InternalHomeScreenBlocEventClearEffect());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('🐧 TCP Penguin'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.coffee_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => context.read<HomeScreenBloc>().add(
                HomeScreenBlocEventClickDonate(),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.save_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () => context.read<HomeScreenBloc>().add(
                HomeScreenBlocEventClickSavedScans(),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),

                Text("Progress", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16.0),

                BlocSelector<HomeScreenBloc, HomeScreenBlocState, double>(
                  selector: (s) => s.progress,
                  builder: (context, progress) {
                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: progress),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          minHeight: 32,
                          borderRadius: BorderRadius.circular(8),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 8.0),

                BlocSelector<HomeScreenBloc, HomeScreenBlocState, String>(
                  selector: (s) => s.progressText,
                  builder: (context, progressText) {
                    return Text(
                      progressText,
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),

                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),

                Text('Output', style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 8.0),

                BlocSelector<HomeScreenBloc, HomeScreenBlocState, String>(
                  selector: (s) => s.scanResultHost,
                  builder: (context, scanResultHost) {
                    return Text(
                      scanResultHost,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),

                const SizedBox(height: 8.0),

                BlocSelector<HomeScreenBloc, HomeScreenBlocState, String>(
                  selector: (s) => s.scanResultOpenPorts,
                  builder: (context, scanResultOpenPorts) {
                    return Text(
                      scanResultOpenPorts,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),

                const SizedBox(height: 8.0),

                BlocSelector<HomeScreenBloc, HomeScreenBlocState, String>(
                  selector: (s) => s.scanResultDuration,
                  builder: (context, scanResultDuration) {
                    return Text(
                      scanResultDuration,
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  },
                ),

                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),

                Text("Input", style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 16.0),

                BlocSelector<
                  HomeScreenBloc,
                  HomeScreenBlocState,
                  (bool, String?)
                >(
                  selector: (s) => (s.isLoading, s.formHostError),
                  builder: (context, values) {
                    final (isLoading, formHostError) = values;
                    // тут

                    return TextField(
                      enabled: !isLoading,
                      controller: textControllerHost,
                      decoration: InputDecoration(
                        labelText: 'Host',
                        border: OutlineInputBorder(),
                        errorText: formHostError,
                      ),
                      keyboardType: TextInputType.url,
                      onChanged: (newHost) {
                        context.read<HomeScreenBloc>().add(
                          HomeScreenBlocEventUpdateHost(host: newHost),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 16.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                          BlocSelector<
                            HomeScreenBloc,
                            HomeScreenBlocState,
                            (bool, String?)
                          >(
                            selector: (s) =>
                                (s.isLoading, s.formPortStartError),
                            builder: (context, values) {
                              final (isLoading, formPortStartError) = values;

                              return TextField(
                                enabled: !isLoading,
                                controller: textControllerPortStart,
                                decoration: InputDecoration(
                                  labelText: 'Port Start [1–…]',
                                  errorText: formPortStartError,
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (newStartPort) {
                                  final intStartPort = int.tryParse(
                                    newStartPort,
                                  );
                                  final intEndPort = int.tryParse(
                                    textControllerPortEnd.text,
                                  );

                                  if (intStartPort != null &&
                                      intStartPort < 1) {
                                    textControllerPortStart.text = '1';
                                    return;
                                  }

                                  if (intStartPort != null &&
                                      intEndPort != null &&
                                      intStartPort > intEndPort) {
                                    textControllerPortStart.text =
                                        textControllerPortEnd.text;
                                    return;
                                  }

                                  context.read<HomeScreenBloc>().add(
                                    HomeScreenBlocEventUpdateStartPort(
                                      port: newStartPort,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    ),

                    SizedBox(width: 16.0),

                    Expanded(
                      child:
                          BlocSelector<
                            HomeScreenBloc,
                            HomeScreenBlocState,
                            (bool, String?)
                          >(
                            selector: (s) => (s.isLoading, s.formPortEndError),
                            builder: (context, values) {
                              final (isLoading, formPortEndError) = values;

                              return TextField(
                                enabled: !isLoading,
                                controller: textControllerPortEnd,
                                decoration: InputDecoration(
                                  labelText: 'Port End […–65535]',
                                  errorText: formPortEndError,
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (newEndPort) {
                                  final intEndPort = int.tryParse(newEndPort);
                                  final intStartPort = int.tryParse(
                                    textControllerPortStart.text,
                                  );

                                  if (intEndPort != null &&
                                      intEndPort > 65535) {
                                    textControllerPortEnd.text = '65535';
                                    return;
                                  }

                                  if (intEndPort != null &&
                                      intStartPort != null &&
                                      intEndPort < intStartPort) {
                                    textControllerPortEnd.text =
                                        textControllerPortStart.text;
                                    return;
                                  }

                                  context.read<HomeScreenBloc>().add(
                                    HomeScreenBlocEventUpdateEndPort(
                                      port: newEndPort,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                BlocSelector<
                  HomeScreenBloc,
                  HomeScreenBlocState,
                  (bool, String?)
                >(
                  selector: (s) => (s.isLoading, s.formWorkersError),
                  builder: (context, values) {
                    final (isLoading, formWorkersError) = values;

                    return TextField(
                      enabled: !isLoading,
                      controller: textControllerWorkers,
                      decoration: InputDecoration(
                        labelText: 'Workers [1–1000]',
                        border: OutlineInputBorder(),
                        errorText: formWorkersError,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (newWorkers) {
                        final intWorkers = int.tryParse(newWorkers);

                        if (intWorkers != null && intWorkers < 1) {
                          textControllerWorkers.text = '1';
                          return;
                        }

                        if (intWorkers != null && intWorkers > 1000) {
                          textControllerWorkers.text = '1000';
                          return;
                        }

                        context.read<HomeScreenBloc>().add(
                          HomeScreenBlocEventUpdateWorkers(workers: newWorkers),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 16),

                BlocSelector<
                  HomeScreenBloc,
                  HomeScreenBlocState,
                  (bool, String?)
                >(
                  selector: (s) => (s.isLoading, s.formTimeoutError),
                  builder: (context, values) {
                    final (isLoading, formTimeoutError) = values;

                    return TextField(
                      enabled: !isLoading,
                      controller: textControllerTimeout,
                      decoration: InputDecoration(
                        labelText: 'Timeout [10–10000 ms]',
                        border: OutlineInputBorder(),
                        errorText: formTimeoutError,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (newTimeout) {
                        final intTimeout = int.tryParse(newTimeout);

                        if (intTimeout != null && intTimeout < 1) {
                          textControllerTimeout.text = '1';
                          return;
                        }

                        if (intTimeout != null && intTimeout > 10000) {
                          textControllerTimeout.text = '10000';
                          return;
                        }

                        context.read<HomeScreenBloc>().add(
                          HomeScreenBlocEventUpdateTimeout(
                            timeoutMs: newTimeout,
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),

                BlocSelector<
                  HomeScreenBloc,
                  HomeScreenBlocState,
                  (bool, String?, String?, String?, String?, String?)
                >(
                  selector: (s) => (
                    s.isLoading,
                    s.formHostError,
                    s.formPortStartError,
                    s.formPortEndError,
                    s.formWorkersError,
                    s.formTimeoutError,
                  ),
                  builder: (context, values) {
                    final (
                      isLoading,
                      formHostError,
                      formPortStartError,
                      formPortEndError,
                      formWorkersError,
                      formTimeoutError,
                    ) = values;

                    final hasError = [
                      formHostError,
                      formPortStartError,
                      formPortEndError,
                      formWorkersError,
                      formTimeoutError,
                    ].any((error) => error != null);

                    return ElevatedButton(
                      onPressed: isLoading || hasError
                          ? null
                          : () => context.read<HomeScreenBloc>().add(
                              HomeScreenBlocEventClickScan(),
                            ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: Text(isLoading ? "Scanning..." : "Start scan"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
