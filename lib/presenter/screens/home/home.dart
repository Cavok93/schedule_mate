import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:today_mate_clean/core/enums/week_day.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import 'package:today_mate_clean/presenter/screens/home/sections/calendar.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import '../../../configs/routes.dart';
import '../../../states/calendar/calendar_bloc.dart';
import '../../../states/calendar/calendar_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late int _initialPage;
  late int _pageCount;
  ScheduleBloc get scheduleBloc => context.read<ScheduleBloc>();

  @override
  void initState() {
    super.initState();
    _initCalender();
  }

  _initCalender() {
    scheduleBloc.add(GetSchedulesEvent());
    final initialDate = DateTime.now();
    final minDate = DateTime(initialDate.year - 3, initialDate.month);
    final maxDate = DateTime(initialDate.year + 3, initialDate.month);
    final dateItemProperties = DateItemProperties(
        initialDate: initialDate,
        minDate: minDate,
        maxDate: maxDate,
        startWeekDay: WeekDay.sunday,
        initialMonth: DateTime(initialDate.year, initialDate.month),
        minMonth: DateTime(minDate.year, minDate.month),
        maxMonth: DateTime(maxDate.year, maxDate.month));
    DateItemStore().set(properties: dateItemProperties);
    _initialPage = Jiffy(dateItemProperties.initialMonth)
        .diff(dateItemProperties.minMonth, Units.MONTH)
        .toInt();
    _pageController = PageController(initialPage: _initialPage);
    _pageCount = Jiffy(dateItemProperties.minMonth)
        .diff(dateItemProperties.maxMonth, Units.MONTH)
        .toInt()
        .abs();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.onPrimary,
          automaticallyImplyLeading: true,
          centerTitle: false,
          elevation: 0.3,
          title: CalendarSelectedAppBarDateSelector((date) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text("${date.month}",
                        style: TextStyle(
                          height: 1,
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                          color: colorScheme.primary,
                        )),
                  ),
                ),
                RichText(
                    text: TextSpan(
                        text: "월",
                        style: TextStyle(
                          height: 1,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.primary,
                        ),
                        children: [
                      TextSpan(
                          text: " • ",
                          style: TextStyle(
                              height: 1, color: colorScheme.primaryContainer)),
                      TextSpan(
                          text: "${date.year}",
                          style: TextStyle(
                              height: 1,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.primaryContainer)),
                    ]))
              ],
            );
          }),
          actions: [
            IconButton(
                onPressed: () {
                  AppNavigator.push(Routes.themes);
                },
                icon: Icon(
                  Icons.color_lens_sharp,
                  color: colorScheme.primary,
                  // color: Colors.red,
                )),
            IconButton(
                onPressed: () {
                  AppNavigator.push(Routes.form, null);
                },
                icon: Icon(
                  Icons.add,
                  color: colorScheme.primary,
                  // color: Colors.red,
                )),
            TextButton(
              onPressed: () {
                if (_pageController.hasClients) {
                  _pageController.animateToPage(_initialPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
                context.read<CalendarBloc>().add(SelectDateEvent(
                    selectedDate: DateTime.utc(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day)));
              },
              child: Text(
                "오늘",
                style: TextStyle(
                    color: colorScheme.primary, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        // body: Container(
        //   padding: EdgeInsets.only(top: 2),
        //   height: 100,
        //   width: 100,
        //   color: Colors.amber,
        //   child: Stack(
        //     children: [
        //       Positioned(
        //         left: 0,
        //         top: 0,
        //         child: Container(
        //           height: 100,
        //           width: 20,
        //           child: FittedBox(
        //             fit: BoxFit.fitHeight,
        //             alignment: Alignment.center,
        //             child: Text(
        //               "야야야야야야야야야야야야야야야야야야야야야야야야",
        //               overflow: TextOverflow.ellipsis,
        //               style: TextStyle(color: Colors.black),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: Calendar(
            pageController: _pageController,
            initialPage: _initialPage,
            pageCount: _pageCount));
  }
}
