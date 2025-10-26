import 'package:tcp_penguin/presentation/common_view/spacer/common_view_spacer.dart';
import 'package:tcp_penguin/presentation/common_view/title/common_view_title.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/view/saved_scans_screen_view_saved_scan.dart';

class SavedScansScreenState {
  final List<SavedScansScreenStateViewItem> viewItems;

  SavedScansScreenState({required this.viewItems});
}

sealed class SavedScansScreenStateViewItem {}

class SavedScansScreenStateViewItemSpacer
    extends SavedScansScreenStateViewItem {
  final CommonViewSpacerEntity entity;

  SavedScansScreenStateViewItemSpacer({required this.entity});
}

class SavedScansScreenStateViewItemTitle extends SavedScansScreenStateViewItem {
  final CommonViewTitleEntity entity;

  SavedScansScreenStateViewItemTitle({required this.entity});
}

class SavedScansScreenStateViewItemSavedScan
    extends SavedScansScreenStateViewItem {
  final SavedScansScreenViewSavedScanEntity entity;

  SavedScansScreenStateViewItemSavedScan({required this.entity});
}
