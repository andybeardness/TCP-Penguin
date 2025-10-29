import 'package:tcp_penguin/presentation/common_dialog/donation/common_dialog_donation.dart';

sealed class HomeScreenBlocEffect {}

class HomeScreenBlocEffectShowDonationDialog extends HomeScreenBlocEffect {
  final CommonDialogDonationEntity entity;

  HomeScreenBlocEffectShowDonationDialog({required this.entity});
}

class HomeScreenBlocEffectNavigateToSavedScans extends HomeScreenBlocEffect {}
