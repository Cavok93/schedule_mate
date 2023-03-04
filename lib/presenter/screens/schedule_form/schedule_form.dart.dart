import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';

import '../../../domain/entities/schedule/schedule.dart';
import '../../../states/calendar/calendar_bloc.dart';

class ScheduleFormScreen extends StatefulWidget {
  final Schedule? targetSchedule;

  const ScheduleFormScreen({
    super.key,
    required this.targetSchedule,
  });

  @override
  State<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends State<ScheduleFormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late int? _id;
  late DateTime _begin;
  late DateTime _end;
  late int _level;
  late bool _isCompleted;
  late DateTime _created;
  CalendarBloc get calendarBloc => context.read<CalendarBloc>();
  @override
  void initState() {
    super.initState();
    _begin = widget.targetSchedule?.begin ?? calendarBloc.state.selectedDate;
    _end = widget.targetSchedule?.end ?? calendarBloc.state.selectedDate;
    _level = widget.targetSchedule?.level ?? 1;
    _isCompleted = widget.targetSchedule?.isCompleted ?? false;
    _id = widget.targetSchedule?.id;
    _created = widget.targetSchedule?.created ?? DateTime.now();
    _titleController.text = widget.targetSchedule?.title ?? "";
    _descriptionController.text = widget.targetSchedule?.description ?? "";
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorScheme.primary),
          backgroundColor: colorScheme.onPrimary,
          elevation: 0.3,
          actions: [
            TextButton(
                onPressed: () async {
                  if (_titleController.text.trim().isEmpty) {
                    return;
                  }
                  if (_begin.compareTo(_end) > 0) {
                    return;
                  }
                  if (widget.targetSchedule == null) {
                    context.read<ScheduleBloc>().add(CreateScheduleEvent(
                        schedule: Schedule(
                            id: _id,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            begin: _begin,
                            end: _end,
                            created: _created,
                            isCompleted: _isCompleted,
                            level: _level)));
                  } else {
                    context.read<ScheduleBloc>().add(UpdateScheduleEvent(
                        schedule: Schedule(
                            id: _id,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            begin: _begin,
                            end: _end,
                            created: _created,
                            isCompleted: _isCompleted,
                            level: _level)));
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  "저장",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: colorScheme.primary),
                ))
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                TextFormField(
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _descriptionController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("시작"),
                    TextButton(
                      onPressed: () {
                        _showDatePicker(context, true, initialDate: _begin);
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                          alignment: Alignment.center),
                      child: Text(DateFormat('yy.MM.dd').format(_begin)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("종료"),
                    TextButton(
                        onPressed: () {
                          _showDatePicker(context, false, initialDate: _end);
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: Size.zero,
                            alignment: Alignment.center),
                        child: Text(DateFormat('yy.MM.dd').format(_end)))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                    children: [1, 2, 3, 4]
                        .map((e) => InkWell(
                              onTap: () {
                                setState(() {
                                  _level = e;
                                });
                                // context.read<TodoViewModel>().selectLevel(e);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                color: e == _level ? Colors.blue : Colors.white,
                                padding: const EdgeInsets.all(8),
                                child: Text("$e"),
                              ),
                            ))
                        .toList()),
              ])),
            )
          ],
        ));
  }

  void _showDatePicker(BuildContext context, bool isStart,
      {required DateTime initialDate}) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        minimumDate: DateItemStore().dateItemProperties.minDate,
                        initialDateTime: initialDate,
                        maximumDate: DateItemStore().dateItemProperties.maxDate,
                        onDateTimeChanged: (date) {
                          if (isStart) {
                            _begin = date;
                          } else {
                            _end = date;
                          }
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ));
  }
}
