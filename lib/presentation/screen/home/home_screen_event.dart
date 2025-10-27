import 'package:tcp_penguin/presentation/common_dialog/donation/common_dialog_donation.dart';

sealed class HomeScreenEvent {}

class HomeScreenEventShowDonateDialog extends HomeScreenEvent {
  final CommonDialogDonationEntity entity;

  HomeScreenEventShowDonateDialog({required this.entity});
}

class HomeScreenEventNavigateToSavedScans extends HomeScreenEvent {}
