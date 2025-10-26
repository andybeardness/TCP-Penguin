import 'package:tcp_penguin/presentation/common_view/spacer/common_view_spacer.dart';
import 'package:tcp_penguin/presentation/common_view/subtitle/common_view_subtitle.dart';
import 'package:tcp_penguin/presentation/common_view/text/common_view_text.dart';
import 'package:tcp_penguin/presentation/common_view/title/common_view_title.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_host.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_progress_bar.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_workers.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_port_range.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_scan_button.dart';
import 'package:tcp_penguin/presentation/screen/home/view/home_screen_view_timeout.dart';

class HomeScreenState {
  List<HomeScreenStateViewItem> viewItems;

  HomeScreenState({required this.viewItems});
}

sealed class HomeScreenStateViewItem {}

class HomeScreenStateViewItemSpacer extends HomeScreenStateViewItem {
  final CommonViewSpacerEntity entity;

  HomeScreenStateViewItemSpacer({required this.entity});
}

class HomeScreenStateViewItemTitle extends HomeScreenStateViewItem {
  final CommonViewTitleEntity entity;

  HomeScreenStateViewItemTitle({required this.entity});
}

class HomeScreenStateViewItemSubtitle extends HomeScreenStateViewItem {
  final CommonViewSubtitleEntity entity;

  HomeScreenStateViewItemSubtitle({required this.entity});
}

class HomeScreenStateViewItemText extends HomeScreenStateViewItem {
  final CommonViewTextEntity entity;

  HomeScreenStateViewItemText({required this.entity});
}

class HomeScreenStateViewItemProgressBar extends HomeScreenStateViewItem {
  final HomeScreenViewProgressBarEntity entity;

  HomeScreenStateViewItemProgressBar({required this.entity});
}

class HomeScreenStateViewItemHost extends HomeScreenStateViewItem {
  final HomeScreenViewHostEntity entity;

  HomeScreenStateViewItemHost({required this.entity});
}

class HomeScreenStateViewItemPortRange extends HomeScreenStateViewItem {
  final HomeScreenViewPortRangeEntity entity;

  HomeScreenStateViewItemPortRange({required this.entity});
}

class HomeScreenStateViewItemMaxWorkers extends HomeScreenStateViewItem {
  final HomeScreenViewWorkersEntity entity;

  HomeScreenStateViewItemMaxWorkers({required this.entity});
}

class HomeScreenStateViewItemTimeout extends HomeScreenStateViewItem {
  final HomeScreenViewTimeoutEntity entity;

  HomeScreenStateViewItemTimeout({required this.entity});
}

class HomeScreenStateViewItemScanButton extends HomeScreenStateViewItem {
  final HomeScreenViewScanButtonEntity entity;

  HomeScreenStateViewItemScanButton({required this.entity});
}
