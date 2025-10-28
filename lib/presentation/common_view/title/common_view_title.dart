import 'package:flutter/material.dart';

class CommonViewTitleEntity {
  final String title;

  CommonViewTitleEntity({required this.title});
}

class CommonViewTitle extends StatelessWidget {
  final CommonViewTitleEntity entity;

  const CommonViewTitle({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(entity.title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}
