import 'dart:io';

sealed class TcpScanerResult {}

class TcpScanerResultSuccess extends TcpScanerResult {}

class TcpScanerResultFailure extends TcpScanerResult {}

class TcpScanner {
  Future<TcpScanerResult> scan({
    required String host,
    required int port,
    required Duration timeout,
  }) async {
    Socket? socket;
    try {
      socket = await Socket.connect(host, port, timeout: timeout);
      return (TcpScanerResultSuccess());
    } catch (e) {
      return (TcpScanerResultFailure());
    } finally {
      socket?.destroy();
    }
  }
}
