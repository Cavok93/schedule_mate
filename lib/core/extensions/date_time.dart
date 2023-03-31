import 'package:intl/intl.dart';

extension KRTime on DateTime {
  String format() => DateFormat(
        "M월d일",
      ).format(this);
}
