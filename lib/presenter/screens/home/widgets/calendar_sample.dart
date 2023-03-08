import 'package:flutter/material.dart';
import 'package:today_mate_clean/configs/constants.dart';
import 'package:today_mate_clean/states/app_theme/app_theme_selector.dart';
import '../../../../../../core/enums/week_day.dart';

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

  static const _todoList = [
    "Design the ads",
    "Prepare the presentation",
    "Present the presentation",
    "Perform Market Research",
    "Test the ads ideas",
    "Go to the gym",
    "Rest ad home"
  ];

  @override
  Widget build(BuildContext context) {
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
                    _buildCell(index),
                    _buildPositionedSampleEvents(
                      topPadding: topPadding,
                      index: index,
                      itemWidth: itemWidth,
                      itemHeight: itemHeight,
                      lineHeight: lineHeight,
                    ),
                    if (index == 3) _buildBorder()
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

  Widget _buildCell(int index) {
    return Container(
      height: monthHeight,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Text(
          "${index + 1}",
          textAlign: TextAlign.center,
          style: TextStyle(
              height: 1, color: index == 0 ? Colors.red : Colors.black),
        ),
      ),
    );
  }

  Widget _buildBorder() {
    return SelectAppThemeSelector((selectedTheme) {
      return Container(
        height: itemHeight,
        width: itemWidth,
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedTheme.themeData.colorScheme.primary,
                width: 1.4)),
      );
    });
  }

  Widget _buildPositionedSampleEvents({
    required double topPadding,
    required int index,
    required double itemWidth,
    required double itemHeight,
    required double lineHeight,
  }) {
    int i = index;
    if (i > CalendarElemetOptions.kMaxLines - 1) {
      i = CalendarElemetOptions.kMaxLines - 1;
    }

    return SelectAppThemeSelector((selectedTheme) {
      Color lineColor =
          _getColor(colorScheme: selectedTheme.themeData.colorScheme, index: i);
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
                    _todoList[index],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: selectedTheme.themeData.colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Color _getColor({required ColorScheme colorScheme, required int index}) {
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
