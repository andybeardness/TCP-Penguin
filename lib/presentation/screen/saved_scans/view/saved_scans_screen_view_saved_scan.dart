import 'package:flutter/material.dart';

class SavedScansScreenViewSavedScanEntity {
  final int id;
  final String host;
  final List<int> openPorts;
  final DateTime createdAt;

  SavedScansScreenViewSavedScanEntity({
    required this.id,
    required this.host,
    required this.openPorts,
    required this.createdAt,
  });
}

class SavedScansScreenViewSavedScan extends StatelessWidget {
  final SavedScansScreenViewSavedScanEntity entity;
  final Function() onDeleteClick;

  const SavedScansScreenViewSavedScan({
    super.key,
    required this.entity,
    required this.onDeleteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.host,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Open Ports: ${entity.openPorts.join(', ')}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Scanned At: ${entity.createdAt}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onDeleteClick,
                icon: Icon(
                  Icons.delete_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
