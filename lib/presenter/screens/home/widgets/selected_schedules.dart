import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/core/extensions/date_time.dart';

import '../../../../domain/entities/schedule/schedule.dart';
import '../../../../states/calendar/calendar_selector.dart';
import '../../../../states/schedule/schedule_bloc.dart';
import '../../../../states/schedule/schedule_selector.dart';
import '../../../widgets/schedule_card.dart';

class SelecteSchedulesSheet extends StatefulWidget {
  const SelecteSchedulesSheet({super.key});

  @override
  State<SelecteSchedulesSheet> createState() => _SelecteSchedulesSheetState();
}

class _SelecteSchedulesSheetState extends State<SelecteSchedulesSheet> {
  int _milliseconds = 350;
  double _height = 0;
  final int _animationRange = 40;
  @override
  Widget build(BuildContext context) {
    final targetSize = MediaQuery.of(context).size.height * 0.3;
    return BlocListener<ScheduleBloc, ScheduleState>(
      listener: (context, sheduleState) {
        if (sheduleState.selectedSchedules.isNotEmpty) {
          setState(() {
            _height = targetSize;
          });
        }
      },
      child: SelectedSchedulesSelector((selectedSchdules) {
        return GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            setState(() {
              _milliseconds = 0;
              _height -= details.delta.dy;
              _height = _height.clamp(0, targetSize);
            });
          },
          onVerticalDragEnd: (details) {
            setState(() {
              _milliseconds = 350;
              if (_height > (targetSize - _animationRange)) {
                _height = targetSize;
              } else {
                _height = 0.0;
              }
            });
          },
          child: AnimatedContainer(
              decoration: BoxDecoration(
                  border: Border(
                      top:
                          BorderSide(color: Colors.grey.shade300, width: 1.0))),
              curve: Curves.fastOutSlowIn,
              height: selectedSchdules.isEmpty ? 0.0 : _height,
              duration: Duration(milliseconds: _milliseconds),
              onEnd: () {
                if (_height < 1) {
                  context
                      .read<ScheduleBloc>()
                      .add(ResetSelectedSchedulesEvent());
                }
              },
              child: Stack(
                children: [_buildListView(selectedSchdules), _buildDoorknob()],
              )),
        );
      }),
    );
  }

  Widget _buildDoorknob() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.transparent,
        height: 30,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CalendarSelectedDateSelector((selectedDate) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.only(left: 16.0, top: 6, bottom: 6),
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    DateTimeX(selectedDate).format().toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              );
            }),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              height: 2.6,
              width: MediaQuery.of(context).size.width * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.grey),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _height = 0.0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
                  child: const FittedBox(
                    fit: BoxFit.fitHeight,
                    child: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.arrow_downward_rounded),
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      iconSize: 26,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<Schedule> selectedSchdules) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 26, left: 8, right: 8),
            separatorBuilder: (context, index) {
              return const SizedBox();
            },
            itemCount: selectedSchdules.length,
            itemBuilder: (context, index) {
              final schedules = selectedSchdules[index];
              return ScheduleCard(
                  schedule: schedules,
                  callBack: (id) {
                    final scheduleBloc = context.read<ScheduleBloc>();
                    scheduleBloc.add(DeleteScheduleEvent(id: id));
                  });
            },
          ),
        ),
      ],
    );
  }
}
