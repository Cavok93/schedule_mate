import 'package:jiffy/jiffy.dart';

class SelectAppBarDateUseCase {
  const SelectAppBarDateUseCase();
  DateTime call(DateTime initialDate, int initialPage, int currentPage) {
    final offset = currentPage - initialPage;
    final date = Jiffy([initialDate.year, initialDate.month])
        .add(months: offset)
        .dateTime;
    return DateTime(date.year, date.month);
  }
}
