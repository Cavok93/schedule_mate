import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:today_mate_clean/presenter/modals/setting_modal.dart';

import '../../../../core/enums/week_day.dart';
import '../../../../domain/entities/calendar/day_props.dart';
import '../../../../states/calendar/calendar_selector.dart';
import '../../../../states/schedule/schedule_bloc.dart';
import '../../../core/utils/calendar_utils.dart';
import '../../../states/calendar/calendar_bloc.dart';
import 'sections/calendar_page_view.dart';

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
  CalendarBloc get calendarBloc => context.read<CalendarBloc>();

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
          GestureDetector(
            onTap: () {
              if (_pageController.hasClients) {
                _pageController.animateToPage(_initialPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }
              calendarBloc.add(SelectDateEvent(
                  selectedDate: DateTime.utc(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day)));
              if (scheduleBloc.state.selectedSchedules.isNotEmpty) {
                scheduleBloc.add(SelectSchedulesEvent(
                    schedules: CalendarUtils.calculateAvailableEventsForDate(
                        scheduleBloc.state.schedules, Jiffy(DateTime.now()))));
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      color: const Color.fromARGB(255, 242, 242, 247),
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    children: const [
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.refresh_sharp),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(0.0),
                        iconSize: 18.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Text(
                        "오늘",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: _showSettingModal,
              child: Container(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  "assets/images/settings.svg",
                ),
              ))
        ],
      ),
      body: Stack(
        children: [
          CalendarPageView(
              pageController: _pageController,
              initialPage: _initialPage,
              pageCount: _pageCount),
        ],
      ),
    );
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
  void initState() {
    super.initState();
    _initCalender();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _showSettingModal() {
    showBarModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        builder: (_) => const SettingModal());
  }
}
