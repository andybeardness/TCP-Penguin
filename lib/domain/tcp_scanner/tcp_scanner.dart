import 'dart:io';

sealed class TcpScanerResult {}

class TcpScanerResultSuccess extends TcpScanerResult {}

class TcpScanerResultFailure extends TcpScanerResult {}

class TcpScanner {
  Future<void> scan({
    required String host,
    required int port,
    required Duration timeout,
    required Function(TcpScanerResult) onResult,
  }) async {
    late Socket socket;
    try {
      socket = await Socket.connect(host, port, timeout: timeout);
      onResult(TcpScanerResultSuccess());
    } catch (e) {
      onResult(TcpScanerResultFailure());
    } finally {
      socket.destroy();
    }
  }
}
