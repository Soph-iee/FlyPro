import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

String formatNumber(num number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

class Log {
  final logger = Logger();
}


Color getBudgetColor(double percent) {
  if (percent < 0.60) {
    return Colors.green;
  } else if (percent < 0.95) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
