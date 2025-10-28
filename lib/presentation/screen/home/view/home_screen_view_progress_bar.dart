import 'package:flutter/material.dart';

class HomeScreenViewProgressBarEntity {
  final double progress;

  HomeScreenViewProgressBarEntity({required this.progress});
}

class HomeScreenViewProgressBar extends StatelessWidget {
  final HomeScreenViewProgressBarEntity entity;

  const HomeScreenViewProgressBar({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: entity.progress,
      minHeight: 32,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
