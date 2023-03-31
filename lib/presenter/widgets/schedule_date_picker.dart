// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import '../../domain/entities/calendar/day_props.dart';

class ScheduleDatePicker extends StatelessWidget {
  final bool isBegin;
  final DateTime initialDate;
  final Function(DateTime date) callBack;
  const ScheduleDatePicker({
    Key? key,
    required this.isBegin,
    required this.initialDate,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CupertinoDatePicker(
              minimumDate: DateItemStore().dateItemProperties.minDate,
              initialDateTime: initialDate,
              maximumDate: DateItemStore().dateItemProperties.maxDate,
              onDateTimeChanged: (date) {
                callBack(date);
              }),
        ),
      ],
    );
  }
}
