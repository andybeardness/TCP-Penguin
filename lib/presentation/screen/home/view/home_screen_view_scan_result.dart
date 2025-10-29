import 'package:flutter/material.dart';

class HomeScreenViewScanResultEntity {
  final String host;
  final List<int> openPorts;

  HomeScreenViewScanResultEntity({required this.host, required this.openPorts});
}

class HomeScreenViewScanResult extends StatelessWidget {
  final HomeScreenViewScanResultEntity? entity;

  const HomeScreenViewScanResult({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final String hostText = entity != null
        ? "Host: ${entity!.host}"
        : 'Host: ...';

    final String openPortsText = entity?.openPorts.isNotEmpty == true
        ? "Open ports: ${entity!.openPorts.join(', ')}"
        : 'Open ports: ...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scan Result', style: Theme.of(context).textTheme.titleLarge),

        const SizedBox(height: 8),

        Text(hostText, style: Theme.of(context).textTheme.bodyMedium),

        const SizedBox(height: 8),

        Text(openPortsText, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
