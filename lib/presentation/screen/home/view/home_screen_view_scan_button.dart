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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: entity.isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48),
          backgroundColor: entity.isEnabled
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withAlpha(100),
          foregroundColor: entity.isEnabled
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onPrimary.withAlpha(100),
        ),
        child: Text(entity.label),
      ),
    );
  }
}
