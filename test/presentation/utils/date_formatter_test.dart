import 'package:flutter_test/flutter_test.dart';
import 'package:tcp_penguin/presentation/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    test('форматирует UTC дату детерминированно', () {
      final dt = DateTime.utc(2025, 5, 8, 18, 50);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-05-08 18:50');
    });

    test('ведущие нули для месяца/дня/часа/минут', () {
      final dt = DateTime.utc(2025, 2, 3, 4, 6);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-02-03 04:06');
    });

    test('конец года', () {
      final dt = DateTime.utc(2025, 12, 31, 23, 59);
      final formatted = DateFormatter.format(dt);
      expect(formatted, '2025-12-31 23:59');
    });
  });
}
