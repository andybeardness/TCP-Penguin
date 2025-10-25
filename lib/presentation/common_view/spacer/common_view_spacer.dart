import 'package:flutter/material.dart';

class CommonViewSpacerEntity {
  final double height;

  CommonViewSpacerEntity({required this.height});
}

class CommonViewSpacer extends StatelessWidget {
  final CommonViewSpacerEntity entity;

  const CommonViewSpacer({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: entity.height);
  }
}
