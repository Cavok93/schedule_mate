import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:today_mate_clean/core/utils/calendar_utils.dart';
import '../../domain/entities/schedule/schedule.dart';
import '../../states/calendar/calendar_bloc.dart';
import '../../states/schedule/schedule_bloc.dart';
import '../widgets/schedule_date_picker.dart';

class ComposeModal extends StatefulWidget {
  final Schedule? targetSchedule;
  const ComposeModal({
    super.key,
    required this.targetSchedule,
  });

  @override
  State<ComposeModal> createState() => _ComposeModalState();
}

class _ComposeModalState extends State<ComposeModal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late int? _id;
  late DateTime _begin;
  late DateTime _end;
  late int _level;
  late bool _isCompleted;
  late DateTime _created;
  CalendarBloc get calendarBloc => context.read<CalendarBloc>();
  bool _showBiginPicker = false;
  bool _showEndPicker = false;
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

  void _saveSchedule() {
    if (_titleController.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "제목을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (_begin.compareTo(_end) > 0) {
      Fluttertoast.showToast(
          msg: "시작날짜가 종료날짜보다 늦습니다. 다시 설정해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: _saveSchedule,
              child: Container(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height,
                alignment: Alignment.center,
                child: Text(
                  widget.targetSchedule == null ? "저장" : "수정",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
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
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 24, color: Colors.grey.shade400),
                          hintText: "제목",
                          fillColor: const Color.fromRGBO(245, 246, 248, 1)),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("시작"),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showBiginPicker = !_showBiginPicker;
                            });
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
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        height: _showBiginPicker
                            ? MediaQuery.of(context).size.height * 0.2
                            : 0.0001,
                        child: ScheduleDatePicker(
                            isBegin: true,
                            initialDate: _begin,
                            callBack: (date) {
                              setState(() {
                                _begin = date;
                              });
                            })),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("종료"),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _showEndPicker = !_showEndPicker;
                              });
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero,
                                alignment: Alignment.center),
                            child: Text(DateFormat('yy.MM.dd').format(_end)))
                      ],
                    ),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        height: _showEndPicker
                            ? MediaQuery.of(context).size.height * 0.2
                            : 0.0001,
                        child: ScheduleDatePicker(
                            isBegin: true,
                            initialDate: _end,
                            callBack: (date) {
                              setState(() {
                                _end = date;
                              });
                            })),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: ["할 일", "일정", "습관", "일기"]
                              .mapIndexed((index, str) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _level = index + 1;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: CalendarUtils
                                                  .extractLevelColor(
                                                      index + 1,
                                                      Theme.of(context)
                                                          .colorScheme)),
                                          color: index + 1 == _level
                                              ? CalendarUtils.extractLevelColor(
                                                  index + 1,
                                                  Theme.of(context).colorScheme)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14.0)),
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            str,
                                            style: TextStyle(
                                                color: _level == index + 1
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer),
                                          )),
                                    ),
                                  ))
                              .toList()),
                    ),
                    const SizedBox(height: 16.0),
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
                                border: Border.all(
                                    color: !_isCompleted
                                        ? Colors.black
                                        : Colors.blueGrey.shade50,
                                    width: 1.0),
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
                                border: Border.all(
                                    color: _isCompleted
                                        ? Colors.black
                                        : Colors.blueGrey.shade50,
                                    width: 1),
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
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        filled: true,
                        focusColor: Color.fromRGBO(245, 246, 248, 1),
                        fillColor: Color.fromRGBO(245, 246, 248, 1),
                      ),
                    ),
                  ])),
                )
              ],
            ),
          ),
        ));
  }
}
