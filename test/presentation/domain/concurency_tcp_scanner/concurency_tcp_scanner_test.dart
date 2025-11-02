import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tcp_penguin/domain/concurency_tcp_scanner/concurency_tcp_scanner.dart';
import 'package:tcp_penguin/domain/tcp_scanner/tcp_scanner.dart';

class _TcpScannerMock extends Mock implements TcpScanner {}

void main() {
  late TcpScanner tcpScanner;
  late ConcurencyTcpScanner concurencyTcpScanner;

  setUp(() {
    tcpScanner = _TcpScannerMock();
    concurencyTcpScanner = ConcurencyTcpScanner(tcpScanner: tcpScanner);
  });

  test('Scan with success results', () async {
    final String host = 'example.com';
    final Duration timeout = Duration(milliseconds: 100);

    double progress = 0;

    when(
      () => tcpScanner.scan(
        host: host,
        port: any(named: 'port'),
        timeout: timeout,
      ),
    ).thenAnswer((_) async {
      return TcpScanerResultSuccess();
    });

    await concurencyTcpScanner.runConcurrently(
      host: host,
      portStart: 1,
      portEnd: 10,
      maxConcurrent: 100,
      timeoutMs: 100,
      onProgress: (double p) {
        progress = p;
      },
    );

    expect(progress, 1);

    verify(
      () => tcpScanner.scan(
        host: any(named: 'host'),
        port: any(named: 'port'),
        timeout: timeout,
      ),
    ).called(10);
  });

  test('Scan with mixed results', () async {
    final String host = 'example.com';
    final Duration timeout = Duration(milliseconds: 100);

    double progress = 0;

    when(
      () => tcpScanner.scan(
        host: host,
        port: any(named: 'port'),
        timeout: timeout,
      ),
    ).thenAnswer((invocation) async {
      final int port = invocation.namedArguments[#port] as int;
      if (port % 2 == 0) {
        return TcpScanerResultSuccess();
      } else {
        return TcpScanerResultFailure();
      }
    });

    await concurencyTcpScanner.runConcurrently(
      host: host,
      portStart: 1,
      portEnd: 10,
      maxConcurrent: 100,
      timeoutMs: 100,
      onProgress: (double p) {
        progress = p;
      },
    );

    expect(progress, 1);

    verify(
      () => tcpScanner.scan(
        host: any(named: 'host'),
        port: any(named: 'port'),
        timeout: timeout,
      ),
    ).called(10);
  });
}
