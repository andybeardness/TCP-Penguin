import 'package:flutter/material.dart';

class HomeScreenViewScanButtonEntity {
  final String label;
  final bool isEnabled;

  HomeScreenViewScanButtonEntity({
    required this.label,
    required this.isEnabled,
  });
}

class HomeScreenViewScanButton extends StatelessWidget {
  final HomeScreenViewScanButtonEntity entity;
  final Function() onPressed;

  const HomeScreenViewScanButton({
    super.key,
    required this.entity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Function()? onPressedEnabled;
    if (entity.isEnabled) {
      onPressedEnabled = onPressed;
    } else {
      onPressedEnabled = null;
    }

    return ElevatedButton(
      onPressed: onPressedEnabled,
      child: Text(entity.label),
    );
  }
}
