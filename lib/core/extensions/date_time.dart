import 'package:intl/intl.dart';

extension SimpleTime on DateTime {
  String format() => DateFormat("yy.MM.dd").format(this);
}
