sealed class TcpScanResult {}

class TcpScanResultSuccess extends TcpScanResult {
  final String host;
  final int port;

  TcpScanResultSuccess({required this.host, required this.port});
}

class TcpScanResultFailure extends TcpScanResult {
  final String host;
  final int port;

  TcpScanResultFailure({required this.host, required this.port});
}
