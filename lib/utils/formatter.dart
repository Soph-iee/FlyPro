import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

String formatNumber(num number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

class Log {
  final logger = Logger();
}
