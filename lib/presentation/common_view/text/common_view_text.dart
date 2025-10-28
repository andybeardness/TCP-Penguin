import 'package:flutter/material.dart';

class CommonViewTextEntity {
  final String text;

  CommonViewTextEntity({required this.text});
}

class CommonViewText extends StatelessWidget {
  final CommonViewTextEntity entity;

  const CommonViewText({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(entity.text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
