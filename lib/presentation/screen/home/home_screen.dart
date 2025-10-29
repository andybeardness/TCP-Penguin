import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/presentation/common_dialog/donation/common_dialog_donation.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_action.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_event.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_view_model.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_form.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_progress_bar.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_scan_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<HomeScreenViewModel>();
    viewModel.event.listen(handleEvent);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.handleAction(action: HomeScreenActionFirstOpenScreen());
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void handleEvent(HomeScreenEvent event) {
    if (!mounted) return;
    if (event is HomeScreenEventShowDonateDialog) {
      CommonDialogDonation.show(
        context: context,
        entity: event.entity,
        onCancel: () {
          context.pop();
        },
        onConfirm: () {
          context.pop();
        },
      );
    } else if (event is HomeScreenEventNavigateToSavedScans) {
      context.push('/saved_scans');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐧 TCP Penguin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.coffee_rounded),
            onPressed: () {
              viewModel.handleAction(action: HomeScreenActionOnClickDonation());
            },
          ),
          IconButton(
            icon: const Icon(Icons.save_rounded),
            onPressed: () {
              viewModel.handleAction(
                action: HomeScreenActionOnClickSavedScans(),
              );
            },
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

              StreamBuilder(
                stream: viewModel.progress$,
                builder: (context, snapshot) {
                  return HomeScreenViewProgressBar(progress: snapshot.data);
                },
              ),

              const SizedBox(height: 8.0),

              const Divider(),

              const SizedBox(height: 8.0),

              StreamBuilder(
                stream: viewModel.scanResult$,
                builder: (context, snapshot) {
                  return HomeScreenViewScanResult(entity: snapshot.data);
                },
              ),

              const SizedBox(height: 8.0),

              const Divider(),

              const SizedBox(height: 8.0),

              StreamBuilder(
                stream: viewModel.form$,
                builder: (context, snapshot) {
                  return HomeScreenViewForm(
                    entity: snapshot.data,
                    onHostChanged: (newHost) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateHost(newHost: newHost),
                      );
                    },
                    onPortStartChanged: (newPortStart) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateStartPort(
                          newStartPort: newPortStart,
                        ),
                      );
                    },
                    onPortEndChanged: (newPortEnd) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateEndPort(
                          newEndPort: newPortEnd,
                        ),
                      );
                    },
                    onTimeoutChanged: (newTimeout) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateTimeout(
                          newTimeoutMs: newTimeout,
                        ),
                      );
                    },

                    onWorkersChanged: (newWorkers) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateMaxWorkers(
                          newMaxWorkers: newWorkers,
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 8.0),

              const Divider(),

              const SizedBox(height: 8.0),

              ElevatedButton(
                onPressed: () {
                  viewModel.handleAction(
                    action: HomeScreenActionOnClickScanButton(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text("Scan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
