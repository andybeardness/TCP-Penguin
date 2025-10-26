import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/presentation/common_view/spacer/common_view_spacer.dart';
import 'package:tcp_penguin/presentation/common_view/subtitle/common_view_subtitle.dart';
import 'package:tcp_penguin/presentation/common_view/text/common_view_text.dart';
import 'package:tcp_penguin/presentation/common_view/title/common_view_title.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_action.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_event.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_state.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_view_model.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_host.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_progress_bar.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_workers.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_port_range.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_scan_button.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_timeout.dart';

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
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void handleEvent(HomeScreenEvent event) {
    if (event is HomeScreenEventNavigateToSavedScans) {
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
            icon: const Icon(Icons.save_rounded),
            onPressed: () {
              viewModel.handleAction(
                action: HomeScreenActionOnClickSavedScans(),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: viewModel.state,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data?.viewItems ?? [];
          return SingleChildScrollView(
            child: Column(
              children: items.map((item) {
                if (item is HomeScreenStateViewItemSpacer) {
                  return CommonViewSpacer(entity: item.entity);
                } else if (item is HomeScreenStateViewItemTitle) {
                  return CommonViewTitle(entity: item.entity);
                } else if (item is HomeScreenStateViewItemSubtitle) {
                  return CommonViewSubtitle(entity: item.entity);
                } else if (item is HomeScreenStateViewItemText) {
                  return CommonViewText(entity: item.entity);
                } else if (item is HomeScreenStateViewItemProgressBar) {
                  return HomeScreenViewProgressBar(entity: item.entity);
                } else if (item is HomeScreenStateViewItemHost) {
                  return HomeScreenViewHost(
                    entity: item.entity,
                    onHostChanged: (newHost) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateHost(newHost: newHost),
                      );
                    },
                  );
                } else if (item is HomeScreenStateViewItemPortRange) {
                  return HomeScreenViewPortRange(
                    entity: item.entity,
                    onStartPortChanged: (newStartPort) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateStartPort(
                          newStartPort: newStartPort,
                        ),
                      );
                    },
                    onEndPortChanged: (newEndPort) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateEndPort(
                          newEndPort: newEndPort,
                        ),
                      );
                    },
                  );
                } else if (item is HomeScreenStateViewItemMaxWorkers) {
                  return HomeScreenViewWorkers(
                    entity: item.entity,
                    onMaxWorkersChanged: (newMaxWorkers) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateMaxWorkers(
                          newMaxWorkers: newMaxWorkers,
                        ),
                      );
                    },
                  );
                } else if (item is HomeScreenStateViewItemTimeout) {
                  return HomeScreenViewTimeout(
                    entity: item.entity,
                    onTimeoutChanged: (newTimeout) {
                      viewModel.handleAction(
                        action: HomeScreenActionUpdateTimeout(
                          newTimeoutMs: newTimeout,
                        ),
                      );
                    },
                  );
                } else if (item is HomeScreenStateViewItemScanButton) {
                  return HomeScreenViewScanButton(
                    entity: item.entity,
                    onPressed: () {
                      viewModel.handleAction(
                        action: HomeScreenActionOnClickScanButton(),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
