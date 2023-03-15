import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/selected_schedules.dart';

import '../../../../core/enums/week_day.dart';
import '../../../../states/calendar/calendar_bloc.dart';
import '../../../../states/schedule/schedule_bloc.dart';
import '../../../../states/schedule/schedule_selector.dart';
import '../widgets/calender_body.dart';
import '../widgets/week_row.dart';

class CalendarPageView extends StatefulWidget {
  final PageController pageController;
  final int initialPage;
  final int pageCount;
  const CalendarPageView(
      {super.key,
      required this.pageController,
      required this.initialPage,
      required this.pageCount});

  @override
  State<CalendarPageView> createState() => _CalendarPageViewState();
}

class _CalendarPageViewState extends State<CalendarPageView> {
  CalendarBloc get calendarBloc => context.read<CalendarBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScheduleStateStatusSelector((status) {
      switch (status) {
        case ScheduleStateStatus.loading:
          return _buildLoading();
        case ScheduleStateStatus.loadSuccess:
          return _buildCalendar();
        case ScheduleStateStatus.loadFailure:
          return _buildError();
        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        const WeekRow(),
        Expanded(
          child: PageView.builder(
              onPageChanged: (currentPage) {
                calendarBloc.add(SelectAppBarDateEvent(
                    initialDate: DateItemStore().dateItemProperties.initialDate,
                    initialPage: widget.initialPage,
                    currentPage: currentPage));
              },
              pageSnapping: true,
              // pageSnapping: false,
              controller: widget.pageController,
              itemCount: widget.pageCount,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, pageIndex) {
                final int offset = pageIndex - widget.initialPage;
                final displayMonth =
                    Jiffy(DateItemStore().dateItemProperties.initialDate)
                        .add(months: offset)
                        .dateTime;
                final display =
                    Jiffy(DateTime.utc(displayMonth.year, displayMonth.month));

                final beginOffset = (DateItemStore()
                            .dateItemProperties
                            .startWeekDay
                            .index >
                        display.day - 1)
                    ? display.day -
                        1 +
                        (WeekDay.values.length -
                            DateItemStore()
                                .dateItemProperties
                                .startWeekDay
                                .index)
                    : display.day -
                        1 -
                        DateItemStore().dateItemProperties.startWeekDay.index;

                int daysInMonth = display.daysInMonth;
                Jiffy beginRange =
                    Jiffy(Jiffy(display).subtract(days: beginOffset));

                return CalendarBody(
                    begin: beginRange,
                    displayMonth: displayMonth,
                    beginOffset: beginOffset,
                    daysInMonth: daysInMonth);
              }),
        ),
        const SelecteSchedulesSheet(),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return const SizedBox();
  }
}
