import 'package:rxdart/rxdart.dart';
import 'package:tcp_penguin/data/repository/host/host_entity.dart';
import 'package:tcp_penguin/data/repository/host/host_repository.dart';
import 'package:tcp_penguin/presentation/common_view/spacer/common_view_spacer.dart';
import 'package:tcp_penguin/presentation/common_view/title/common_view_title.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_action.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_event.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen_state.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/view/saved_scans_screen_view_saved_scan.dart';

class SavedScansScreenViewModel {
  final HostRepository hostRepository;

  final BehaviorSubject<SavedScansScreenState> state =
      BehaviorSubject<SavedScansScreenState>.seeded(
        SavedScansScreenState(viewItems: []),
      );

  final BehaviorSubject<SavedScansScreenEvent> event =
      BehaviorSubject<SavedScansScreenEvent>();

  void dispose() {
    state.close();
    event.close();
  }

  SavedScansScreenViewModel({required this.hostRepository}) {
    Rx.combineLatest([hostRepository.hosts], (streams) {
      final List<HostEntity> hosts = streams[0];

      final viewItems = <SavedScansScreenStateViewItem>[];

      viewItems.add(
        SavedScansScreenStateViewItemSpacer(
          entity: CommonViewSpacerEntity(height: 16),
        ),
      );

      viewItems.add(
        SavedScansScreenStateViewItemTitle(
          entity: CommonViewTitleEntity(title: 'Saved Scans'),
        ),
      );

      viewItems.add(
        SavedScansScreenStateViewItemSpacer(
          entity: CommonViewSpacerEntity(height: 8),
        ),
      );

      for (final host in hosts) {
        viewItems.add(
          SavedScansScreenStateViewItemSavedScan(
            entity: SavedScansScreenViewSavedScanEntity(
              id: host.id,
              host: host.host,
              openPorts: host.openPorts,
              createdAt: host.createdAt,
            ),
          ),
        );

        viewItems.add(
          SavedScansScreenStateViewItemSpacer(
            entity: CommonViewSpacerEntity(height: 8),
          ),
        );
      }

      return SavedScansScreenState(viewItems: viewItems);
    }).listen((newState) {
      state.add(newState);
    });
  }

  void onAction({required SavedScansScreenAction action}) {
    if (action is SavedScansScreenActionOnClickNavigateBack) {
      event.add(SavedScansScreenEventNavigateBack());
    } else if (action is SavedScansScreenActionOnClickDeleteSavedScan) {
      hostRepository.deleteHost(id: action.id);
    }
  }
}
