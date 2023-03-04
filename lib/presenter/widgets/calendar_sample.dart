import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/configs/constants.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';
import 'package:today_mate_clean/states/theme/theme_cubit.dart';

import '../../../../core/enums/week_day.dart';
import '../../../../core/utils/calendar_utils.dart';

class CalendarSample extends StatelessWidget {
  final double itemHeight;
  final double itemWidth;
  final double monthHeight;
  final double topPadding;
  final double lineHeight;

  const CalendarSample(
      {super.key,
      required this.itemHeight,
      required this.itemWidth,
      required this.monthHeight,
      required this.topPadding,
      required this.lineHeight});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeCubit>().state;
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: itemHeight,
        child: IgnorePointer(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: itemHeight,
                width: itemWidth,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.grey.shade400, width: 0.0)),
                child: Stack(
                  children: [
                    Container(
                      height: monthHeight,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 3),
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Text(
                          "${index + 1}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1,
                              color: index == 0 ? Colors.red : Colors.black),
                        ),
                      ),
                    ),
                    _buildPositionedSampleEvents(
                        topPadding: topPadding,
                        index: index,
                        itemWidth: itemWidth,
                        itemHeight: itemHeight,
                        lineHeight: lineHeight,
                        colorScheme: state.selectedThems.themeData.colorScheme),
                    if (index == 3)
                      Container(
                        height: itemHeight,
                        width: itemWidth,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: state.selectedThems.themeData.colorScheme
                                    .primary,
                                width: 1.4)),
                      ),
                  ],
                ),
              );
            },
            itemCount: WeekDay.values.length,
          ),
        ),
      );
    });
  }

  Widget _buildPositionedSampleEvents({
    required double topPadding,
    required int index,
    required double itemWidth,
    required double itemHeight,
    required double lineHeight,
    required ColorScheme colorScheme,
  }) {
    int i = index;
    if (i > CalendarConstants.kMaxLines - 1) {
      i = CalendarConstants.kMaxLines - 1;
    }
    final todoList = [
      "Design the ads",
      "Prepare the presentation",
      "Present the presentation",
      "Perform Market Research",
      "Test the ads ideas",
      "Go to the gym",
      "Rest ad home"
    ];

    Color lineColor = getColor(colorScheme: colorScheme, index: i);
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: i * lineHeight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              width: itemWidth,
              height: lineHeight,
              color: lineColor,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                // clipBehavior: Clip.hardEdge,
                alignment: Alignment.centerLeft,
                child: Text(
                  todoList[index],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor({required ColorScheme colorScheme, required int index}) {
    if (index == 0) {
      return colorScheme.primary;
    } else if (index == 1) {
      return colorScheme.secondary;
    } else if (index == 2) {
      return colorScheme.secondaryContainer;
    } else {
      return colorScheme.tertiary;
    }
  }
}
