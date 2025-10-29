import 'package:flutter/material.dart';

class HomeScreenViewFormEntity {
  final String host;
  final int portStart;
  final int portEnd;
  final int workers;
  final int timeout;

  HomeScreenViewFormEntity({
    required this.host,
    required this.portStart,
    required this.portEnd,
    required this.workers,
    required this.timeout,
  });

  HomeScreenViewFormEntity copyWith({
    String? host,
    int? portStart,
    int? portEnd,
    int? workers,
    int? timeout,
  }) {
    return HomeScreenViewFormEntity(
      host: host ?? this.host,
      portStart: portStart ?? this.portStart,
      portEnd: portEnd ?? this.portEnd,
      workers: workers ?? this.workers,
      timeout: timeout ?? this.timeout,
    );
  }
}

class HomeScreenViewForm extends StatefulWidget {
  final HomeScreenViewFormEntity? entity;
  final Function(String newHost) onHostChanged;
  final Function(int newPortStart) onPortStartChanged;
  final Function(int newPortEnd) onPortEndChanged;
  final Function(int newWorkers) onWorkersChanged;
  final Function(int newTimeout) onTimeoutChanged;

  const HomeScreenViewForm({
    super.key,
    required this.entity,
    required this.onHostChanged,
    required this.onPortStartChanged,
    required this.onPortEndChanged,
    required this.onWorkersChanged,
    required this.onTimeoutChanged,
  });

  @override
  State<HomeScreenViewForm> createState() => _HomeScreenViewFormState();
}

class _HomeScreenViewFormState extends State<HomeScreenViewForm> {
  final _hostController = TextEditingController();
  final _portStartController = TextEditingController();
  final _portEndController = TextEditingController();
  final _workersController = TextEditingController();
  final _timeoutController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _hostController.text = widget.entity?.host ?? '';
    _portStartController.text = widget.entity?.portStart.toString() ?? '';
    _portEndController.text = widget.entity?.portEnd.toString() ?? '';
    _workersController.text = widget.entity?.workers.toString() ?? '';
    _timeoutController.text = widget.entity?.timeout.toString() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Scan Configuration",
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 16),

        TextField(
          controller: _hostController,
          decoration: InputDecoration(
            labelText: 'Host',
            border: OutlineInputBorder(),
          ),
          onChanged: widget.onHostChanged,
        ),

        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _portStartController,
                decoration: InputDecoration(
                  labelText: 'Port Start',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (newStartPort) {
                  if (newStartPort.isEmpty) return;

                  final int? intStartPort = int.tryParse(newStartPort);
                  final int? intEndPort = int.tryParse(_portEndController.text);

                  if (intStartPort == null) {
                    _portStartController.text = '1';
                    return;
                  }

                  if (intStartPort < 1) {
                    _portStartController.text = '1';
                    return;
                  }

                  if (intEndPort != null && intStartPort > intEndPort) {
                    _portStartController.text = _portEndController.text;
                    return;
                  }

                  widget.onPortStartChanged(intStartPort);
                },
              ),
            ),

            SizedBox(width: 16),

            Expanded(
              child: TextField(
                controller: _portEndController,
                decoration: InputDecoration(
                  labelText: 'Port End',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String newPortEnd) {
                  if (newPortEnd.isEmpty) return;

                  final int? intEndPort = int.tryParse(newPortEnd);
                  final int? intStartPort = int.tryParse(
                    _portStartController.text,
                  );

                  if (intEndPort == null) {
                    _portEndController.text = '255';
                    return;
                  }

                  if (intEndPort > 65535) {
                    _portEndController.text = '65535';
                    return;
                  }

                  if (intStartPort != null && intStartPort > intEndPort) {
                    _portEndController.text = _portStartController.text;
                    return;
                  }

                  widget.onPortEndChanged(intEndPort);
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        TextField(
          controller: _workersController,
          decoration: InputDecoration(
            labelText: 'Workers',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),

        SizedBox(height: 16),

        TextField(
          controller: _timeoutController,
          decoration: InputDecoration(
            labelText: 'Timeout (ms)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
