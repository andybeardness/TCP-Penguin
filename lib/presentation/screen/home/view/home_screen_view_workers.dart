import 'package:flutter/material.dart';

class HomeScreenViewWorkersEntity {
  final String maxWorkers;
  final String? errorText;

  HomeScreenViewWorkersEntity({
    required this.maxWorkers,
    required this.errorText,
  });
}

class HomeScreenViewWorkers extends StatefulWidget {
  final HomeScreenViewWorkersEntity entity;
  final Function(String newMaxWorkers) onMaxWorkersChanged;

  const HomeScreenViewWorkers({
    super.key,
    required this.entity,
    required this.onMaxWorkersChanged,
  });

  @override
  State<HomeScreenViewWorkers> createState() => _HomeScreenViewWorkersState();
}

class _HomeScreenViewWorkersState extends State<HomeScreenViewWorkers> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.entity.maxWorkers.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Workers (1-500)',
        border: OutlineInputBorder(),
        errorText: widget.entity.errorText,
      ),
      controller: _controller,
      keyboardType: TextInputType.number,
      onChanged: (String newWorkersCount) {
        if (newWorkersCount.isEmpty) {
          widget.onMaxWorkersChanged(newWorkersCount);
          return;
        }

        final count = int.tryParse(newWorkersCount);

        if (count == null || count <= 0) {
          newWorkersCount = '1';
        } else if (count >= 500) {
          newWorkersCount = '500';
        }

        _controller.text = newWorkersCount;

        widget.onMaxWorkersChanged(newWorkersCount);
      },
    );
  }
}
