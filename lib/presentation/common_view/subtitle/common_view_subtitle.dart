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
    return SizedBox(
      width: double.infinity,
      child: Text(
        entity.subtitle,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
