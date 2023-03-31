import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../core/extensions/date_time.dart';
import '../../domain/entities/schedule/schedule.dart';
import '../modals/compose_modal.dart';

class CreateCard extends StatelessWidget {
  final Function callBack;
  const CreateCard({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showComposeModal(context, null);
      },
      child: Card(
        elevation: 0.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 1.0)),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        "assets/images/add.svg",
                        height: 24.0,
                        width: 24.0,
                      )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.only(
                            left: 0, top: 12, right: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "이벤트 추가",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              "${KRTime(DateTime.now()).format()} - ${KRTime(DateTime.now()).format()}",
                              style: const TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComposeModal(BuildContext context, Schedule? targetSchedule) {
    showBarModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        builder: (_) => ComposeModal(targetSchedule: targetSchedule));
  }
}
