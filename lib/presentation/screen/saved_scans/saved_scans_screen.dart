import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcp_penguin/app/di/di.dart';
import 'package:tcp_penguin/presentation/common_view/spacer/common_view_spacer.dart';
import 'package:tcp_penguin/presentation/common_view/title/common_view_title.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_action.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_event.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_state.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_view_model.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/view/saved_scans_screen_view_saved_scan.dart';

class SavedScansScreen extends StatefulWidget {
  const SavedScansScreen({super.key});

  @override
  State<SavedScansScreen> createState() => _SavedScansScreenState();
}

class _SavedScansScreenState extends State<SavedScansScreen> {
  late final SavedScansScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<SavedScansScreenViewModel>();
    viewModel.event.listen(handleEvent);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void handleEvent(SavedScansScreenEvent event) {
    if (event is SavedScansScreenEventNavigateBack) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Scans'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            viewModel.onAction(
              action: SavedScansScreenActionOnClickNavigateBack(),
            );
          },
        ),
      ),
      body: StreamBuilder(
        stream: viewModel.state,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }

          final items = snapshot.data?.viewItems ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items.map((item) {
                if (item is SavedScansScreenStateViewItemSpacer) {
                  return CommonViewSpacer(entity: item.entity);
                } else if (item is SavedScansScreenStateViewItemTitle) {
                  return CommonViewTitle(entity: item.entity);
                } else if (item is SavedScansScreenStateViewItemSavedScan) {
                  return SavedScansScreenViewSavedScan(
                    entity: item.entity,
                    onDeleteClick: () {
                      viewModel.onAction(
                        action: SavedScansScreenActionOnClickDeleteSavedScan(
                          id: item.entity.id,
                        ),
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
