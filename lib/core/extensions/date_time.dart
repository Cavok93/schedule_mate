import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format() => DateFormat(
        "M월d일",
      ).format(this);

  // String formatYYMMDD() => DateFormat(
  //       "",
  //     ).format(this);
}
