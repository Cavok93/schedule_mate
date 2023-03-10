import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format() => DateFormat("yy.MM.dd").format(this);
}
