import 'package:intl/intl.dart';


extension DateTimeExtension on DateTime {
  String get formatDateTimeString => DateFormat('dd/MM/yyyy HH:mm aaa').format(this);
  String get formatDayString => DateFormat('EEE, MMM d, yyyy').format(this);
}
