import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_mate_clean/presenter/modals/date_modal.dart';
import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';

import '../../../../domain/entities/schedule/schedule.dart';
import '../../../../states/calendar/calendar_bloc.dart';

class ComposeScreen extends StatefulWidget {
  final Schedule? targetSchedule;

  const ComposeScreen({
    super.key,
    required this.targetSchedule,
  });

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
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
          title: Text(
            widget.targetSchedule != null ? "수정" : "할 일",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 17),
          ),
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  TextFormField(
                    style: const TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 24, color: Colors.grey.shade400),
                        hintText: "제목을 입력해주세요.",
                        fillColor: Colors.white),
                    controller: _titleController,
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("시작"),
                      TextButton(
                        onPressed: () {
                          _showDateModal(context, true, initialDate: _begin);
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
                            _showDateModal(context, false, initialDate: _end);
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
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  color:
                                      e == _level ? Colors.blue : Colors.white,
                                  padding: const EdgeInsets.all(8),
                                  child: Text("$e"),
                                ),
                              ))
                          .toList()),
                  const SizedBox(height: 30.0),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCompleted = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: !_isCompleted
                                  ? Colors.blueGrey.shade200
                                  : null,
                              border: Border.all(
                                  color: Colors.blueGrey, width: 0.8),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          alignment: Alignment.center,
                          child: const Text("미완료"),
                        ),
                      )),
                      const SizedBox(width: 16.0),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCompleted = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: _isCompleted
                                  ? Colors.blueGrey.shade200
                                  : null,
                              border: Border.all(
                                  color: Colors.blueGrey, width: 0.8),
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          alignment: Alignment.center,
                          child: const Text("완료"),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    "메모",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    style: const TextStyle(fontSize: 16.0),
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "메모",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(245, 246, 248, 1),
                    ),
                  ),
                ])),
              )
            ],
          ),
        ));
  }

  void _showDateModal(BuildContext context, bool isBegin,
      {required DateTime initialDate}) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        builder: (_) => DateModal(
            isBegin: isBegin,
            initialDate: initialDate,
            callBack: (date) {
              if (isBegin) {
                _begin = date;
              } else {
                _end = date;
              }
              setState(() {});
            }));
  }
}
