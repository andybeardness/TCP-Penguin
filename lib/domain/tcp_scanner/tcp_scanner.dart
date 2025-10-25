import 'dart:io';

import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner_result.dart';

class TcpScanner {
  Future<void> scan({
    required String host,
    required int port,
    required Duration timeout,
    required Function(TcpScanResult) onResult,
  }) async {
    try {
      final socket = await Socket.connect(host, port, timeout: timeout);
      socket.destroy();
      onResult(TcpScanResultSuccess(host: host, port: port));
    } on SocketException {
      onResult(TcpScanResultFailure(host: host, port: port));
    } catch (e) {
      onResult(TcpScanResultFailure(host: host, port: port));
    }
  }
}
