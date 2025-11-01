import 'package:flutter_test/flutter_test.dart';
import 'package:tcp_penguin/presentation/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('Format my birthday', () {
      final dt = DateTime.utc(2025, 5, 8, 18, 50);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-05-08 18:50');
    });

    test('Leading zeros for month/day/hour/minute', () {
      final dt = DateTime.utc(2025, 2, 3, 4, 6);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-02-03 04:06');
    });

    test('End of the year', () {
      final dt = DateTime.utc(2025, 12, 31, 23, 59);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-12-31 23:59');
    });

    test('Beginning of the year', () {
      final dt = DateTime.utc(2025, 1, 1, 0, 0);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-01-01 00:00');
    });
  });
}
