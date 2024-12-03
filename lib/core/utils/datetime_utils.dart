import 'package:intl/intl.dart';

String formatStringDate(String date, {String? format}) {
  if (date.isEmpty) return '';
  return DateFormat(format ?? 'MMM dd, yyyy').format(DateTime.parse(date));
}

String formatDate(DateTime date, {String? format}) {
  return DateFormat(format ?? 'MMM dd, yyyy').format(date);
}
