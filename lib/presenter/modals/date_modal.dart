// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/calendar/day_props.dart';

class DateModal extends StatelessWidget {
  final bool isBegin;
  final DateTime initialDate;
  final Function(DateTime date) callBack;
  const DateModal({
    Key? key,
    required this.isBegin,
    required this.initialDate,
    required this.callBack,
  }) : super(key: key);

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 16),
      height: 4,
      width: 24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.grey),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Expanded(
      child: CupertinoDatePicker(
          minimumDate: DateItemStore().dateItemProperties.minDate,
          initialDateTime: initialDate,
          maximumDate: DateItemStore().dateItemProperties.maxDate,
          onDateTimeChanged: (date) {
            callBack(date);
          }),
    );
  }

  Widget _buildCompleteButton(BuildContext context) {
    return CupertinoButton(
      child: const Text('OK'),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom:
              Platform.isAndroid ? 16 : MediaQuery.of(context).padding.bottom),
      child: Column(
        children: [
          _buildHeader(),
          _buildDatePicker(context),
          _buildCompleteButton(context)
        ],
      ),
    );
  }
}
