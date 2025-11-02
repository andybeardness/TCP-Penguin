import 'package:pool/pool.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';

class ConcurencyTcpScanner {
  final TcpScanner tcpScanner;

  ConcurencyTcpScanner({required this.tcpScanner});

  Future<List<int>> runConcurrently({
    required String host,
    required int portStart,
    required int portEnd,
    required int maxConcurrent,
    required int timeoutMs,
    required Function(double progress) onProgress,
  }) async {
    final pool = Pool(maxConcurrent);

    final List<Future<void>> tasks = [];

    final List<int> openPorts = [];
    final totalPorts = portEnd - portStart + 1;
    int completedPorts = 0;

    for (var port = portStart; port <= portEnd; port++) {
      final resource = await pool.request();
      tasks.add(
        Future(() async {
          final scanResult = await tcpScanner.scan(
            host: host,
            port: port,
            timeout: Duration(milliseconds: timeoutMs),
          );

          if (scanResult is TcpScanerResultSuccess) {
            openPorts.add(port);
          }

          resource.release();
          completedPorts++;
          onProgress(completedPorts / totalPorts);
        }),
      );
    }

    await Future.wait(tasks);
    await pool.close();

    return openPorts;
  }
}
