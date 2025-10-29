import 'package:flutter/material.dart';

class HomeScreenViewProgressBar extends StatelessWidget {
  final double? progress;

  const HomeScreenViewProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress', style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 8),

        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress ?? 0),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              minHeight: 32,
              borderRadius: BorderRadius.circular(8),
            );
          },
        ),

        const SizedBox(height: 8),

        Text(
          progress != null && progress! < 1
              ? 'Scanning in progress. Don\'t close the app'
              : 'Ready to scan',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
