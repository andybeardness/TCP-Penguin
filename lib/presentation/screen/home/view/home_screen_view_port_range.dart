import 'package:flutter/material.dart';

class HomeScreenViewPortRangeEntity {
  final String startPort;
  final String? startPortErrorText;

  final String endPort;
  final String? endPortErrorText;

  HomeScreenViewPortRangeEntity({
    required this.startPort,
    required this.startPortErrorText,
    required this.endPort,
    required this.endPortErrorText,
  });
}

class HomeScreenViewPortRange extends StatefulWidget {
  final HomeScreenViewPortRangeEntity entity;
  final Function(String newStartPort) onStartPortChanged;
  final Function(String newEndPort) onEndPortChanged;

  const HomeScreenViewPortRange({
    super.key,
    required this.entity,
    required this.onStartPortChanged,
    required this.onEndPortChanged,
  });

  @override
  State<HomeScreenViewPortRange> createState() =>
      _HomeScreenViewPortRangeState();
}

class _HomeScreenViewPortRangeState extends State<HomeScreenViewPortRange> {
  late TextEditingController _startPortController;
  late TextEditingController _endPortController;

  @override
  void initState() {
    super.initState();
    _startPortController = TextEditingController(text: widget.entity.startPort);
    _endPortController = TextEditingController(text: widget.entity.endPort);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Start Port (1-...)',
              border: OutlineInputBorder(),
              errorText: widget.entity.startPortErrorText,
            ),
            controller: _startPortController,
            keyboardType: TextInputType.number,
            onChanged: (String newStartPort) {
              if (newStartPort.isEmpty) {
                widget.onStartPortChanged(newStartPort);
                return;
              }

              final startPort = int.tryParse(newStartPort);

              if (startPort == null || startPort < 1) {
                newStartPort = '1';
              } else if (startPort > 65535) {
                newStartPort = '65535';
              }

              _startPortController.text = newStartPort;

              widget.onStartPortChanged(newStartPort);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'End Port (...-65535)',
              border: OutlineInputBorder(),
              errorText: widget.entity.endPortErrorText,
            ),
            controller: _endPortController,
            keyboardType: TextInputType.number,
            onChanged: (String newEndPort) {
              if (newEndPort.isEmpty) {
                widget.onEndPortChanged(newEndPort);
                return;
              }

              final endPort = int.tryParse(newEndPort);

              if (endPort == null || endPort < 1) {
                newEndPort = '1';
              } else if (endPort > 65535) {
                newEndPort = '65535';
              }

              _endPortController.text = newEndPort;

              widget.onEndPortChanged(newEndPort);
            },
          ),
        ),
      ],
    );
  }
}
