import 'package:flutter/material.dart';

class HomeScreenViewHostEntity {
  final String host;
  final String? errorText;

  HomeScreenViewHostEntity({required this.host, required this.errorText});
}

class HomeScreenViewHost extends StatefulWidget {
  final HomeScreenViewHostEntity entity;
  final Function(String newHost) onHostChanged;

  const HomeScreenViewHost({
    super.key,
    required this.entity,
    required this.onHostChanged,
  });

  @override
  State<HomeScreenViewHost> createState() => _HomeScreenViewHostState();
}

class _HomeScreenViewHostState extends State<HomeScreenViewHost> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.entity.host);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Host',
          border: const OutlineInputBorder(),
          errorText: widget.entity.errorText,
        ),
        textCapitalization: TextCapitalization.none,
        controller: _controller,
        onChanged: widget.onHostChanged,
      ),
    );
  }
}
