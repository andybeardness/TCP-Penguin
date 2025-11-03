import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ScanItem {
  final String host;
  final List<int> openPorts;
  final DateTime dateTime;

  ScanItem({
    required this.host,
    required this.openPorts,
    required this.dateTime,
  });
}

class ScansSharer {
  Future<void> saveScansAsCsv({required List<ScanItem> scans}) async {
    final rows = [
      ['host', 'open_ports', 'date_time'],
      ...scans.map(
        (scan) => [
          scan.host,
          scan.openPorts.join(' '),
          scan.dateTime.toIso8601String(),
        ],
      ),
    ];

    final csvData = ListToCsvConverter().convert(rows);

    Directory dir;
    if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectory())!;
    } else if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    final filePath =
        '${dir.path}/scan_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = File(filePath);

    await file.writeAsString(csvData);

    final xFile = XFile(
      filePath,
      mimeType: 'text/csv',
      name: 'scan_results.csv',
    );

    await SharePlus.instance.share(
      ShareParams(
        files: [xFile],
        text: 'Результаты сканирования портов',
        subject: 'TCP Penguin scan results',
      ),
    );
  }
}
