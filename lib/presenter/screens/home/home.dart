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
import 'sections/calendar_page.dart';

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
              onTap: _showSettingModal,
              child: Container(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  "assets/images/settings.svg",
                ),
              ))
          // IconButton(
          //     onPressed: () {
          //       AppNavigator.push(Routes.themes);
          //     },
          //     icon: Icon(
          //       Icons.color_lens_sharp,
          //       color: colorScheme.primary,
          //     )),
          // IconButton(
          //     onPressed: () {
          //       AppNavigator.push(Routes.form, null);
          //     },
          //     icon: Icon(
          //       Icons.add,
          //       color: colorScheme.primary,
          //       // color: Colors.red,
          //     )),
          // TextButton(
          //   onPressed: () {
          //     if (_pageController.hasClients) {
          //       _pageController.animateToPage(_initialPage,
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeIn);
          //     }
          //     context.read<CalendarBloc>().add(SelectDateEvent(
          //         selectedDate: DateTime.utc(DateTime.now().year,
          //             DateTime.now().month, DateTime.now().day)));
          //   },
          //   child: Text(
          //     "오늘",
          //     style: TextStyle(
          //         color: colorScheme.primary, fontWeight: FontWeight.w500),
          //   ),
          // )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CalendarPageView(
                pageController: _pageController,
                initialPage: _initialPage,
                pageCount: _pageCount),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: colorScheme.onPrimary,
          ),
          onPressed: () {}),
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
