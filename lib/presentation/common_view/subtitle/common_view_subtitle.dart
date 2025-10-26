import 'package:flutter/material.dart';

class CommonViewSubtitleEntity {
  final String subtitle;

  CommonViewSubtitleEntity({required this.subtitle});
}

class CommonViewSubtitle extends StatelessWidget {
  final CommonViewSubtitleEntity entity;

  const CommonViewSubtitle({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        entity.subtitle,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
