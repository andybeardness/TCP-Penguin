import 'package:flutter/material.dart';

class HomeScreenViewTimeoutEntity {
  final String timeoutMs;
  final String? errorText;

  HomeScreenViewTimeoutEntity({
    required this.timeoutMs,
    required this.errorText,
  });
}

class HomeScreenViewTimeout extends StatefulWidget {
  final HomeScreenViewTimeoutEntity entity;
  final Function(String newTimeoutMs) onTimeoutChanged;

  const HomeScreenViewTimeout({
    super.key,
    required this.entity,
    required this.onTimeoutChanged,
  });

  @override
  State<HomeScreenViewTimeout> createState() => _HomeScreenViewTimeoutState();
}

class _HomeScreenViewTimeoutState extends State<HomeScreenViewTimeout> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.entity.timeoutMs.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Timeout ms (1-60000)',
        border: OutlineInputBorder(),
        errorText: widget.entity.errorText,
      ),
      controller: _controller,
      keyboardType: TextInputType.number,
      onChanged: (String newTimeoutMs) {
        if (newTimeoutMs.isEmpty) {
          widget.onTimeoutChanged(newTimeoutMs);
          return;
        }

        final timeout = int.tryParse(newTimeoutMs);

        if (timeout == null || timeout <= 1) {
          newTimeoutMs = '1';
        } else if (timeout >= 60000) {
          newTimeoutMs = '60000';
        }

        _controller.text = newTimeoutMs;

        widget.onTimeoutChanged(newTimeoutMs);
      },
    );
  }
}
