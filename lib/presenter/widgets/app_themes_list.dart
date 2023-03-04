import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/domain/entities/calendar/day_props.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/calendar_header.dart';
import 'package:today_mate_clean/presenter/widgets/calendar_sample.dart';
import 'package:today_mate_clean/states/theme/theme_cubit.dart';

import '../../configs/constants.dart';
import '../../core/enums/week_day.dart';

class AppThemesList extends StatefulWidget {
  const AppThemesList({super.key});

  @override
  State<AppThemesList> createState() => _AppThemesListState();
}

class _AppThemesListState extends State<AppThemesList> {
  ThemeCubit get themeCubit => context.read<ThemeCubit>();
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ThemeCubit>().state;
    final double bottomPadding =
        Platform.isAndroid ? 16 : MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        final double itemWidth = constraints.maxWidth / WeekDay.values.length;
        final double itemHeight = itemWidth * 2.13;
        const double itemInset = 3;
        final double monthHeight = itemWidth / 3;
        final double topPadding = itemWidth / 2;
        final double totalContentSize =
            itemHeight - topPadding - (WeekDay.values.length * itemInset);
        final double lineHeight =
            totalContentSize / CalendarConstants.kMaxLines;
        return Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text("9",
                              style: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.w900,
                                fontSize: 50,
                                color: state.selectedThems.themeData.colorScheme
                                    .primary,
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
                                color: state.selectedThems.themeData.colorScheme
                                    .primary,
                              ),
                              children: [
                            TextSpan(
                                text: " • ",
                                style: TextStyle(
                                    height: 1,
                                    color: state.selectedThems.themeData
                                        .colorScheme.primaryContainer)),
                            TextSpan(
                                text: "2030",
                                style: TextStyle(
                                    height: 1,
                                    fontWeight: FontWeight.w500,
                                    color: state.selectedThems.themeData
                                        .colorScheme.primaryContainer)),
                          ])),
                    ],
                  ),
                ),
                const CalendarHeader(),
                CalendarSample(
                    itemHeight: itemHeight,
                    itemWidth: itemWidth,
                    monthHeight: monthHeight,
                    topPadding: topPadding,
                    lineHeight: lineHeight)
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // SliverAppBar(
                  //   primary: false,
                  //   backgroundColor:
                  //       state.selectedThems.themeData.colorScheme.onPrimary,
                  //   automaticallyImplyLeading: false,
                  //   titleSpacing: 0.0,
                  //   pinned: true,
                  //   elevation: 0.3,
                  //   floating: true,
                  //   toolbarHeight: CalendarConstants.kWeekHeaderHeight +
                  //       AppBar().preferredSize.height +
                  //       itemHeight,
                  //   title: Column(
                  //     children: [
                  //       Padding(
                  //         padding:
                  //             const EdgeInsets.only(left: 16, right: 16, top: 20),
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.baseline,
                  //           textBaseline: TextBaseline.ideographic,
                  //           children: [
                  //             SizedBox(
                  //               height: AppBar().preferredSize.height,
                  //               child: FittedBox(
                  //                 fit: BoxFit.fitHeight,
                  //                 child: Text("9",
                  //                     style: TextStyle(
                  //                       height: 1,
                  //                       fontWeight: FontWeight.w900,
                  //                       fontSize: 50,
                  //                       color: state.selectedThems.themeData
                  //                           .colorScheme.primary,
                  //                     )),
                  //               ),
                  //             ),
                  //             RichText(
                  //                 text: TextSpan(
                  //                     text: "월",
                  //                     style: TextStyle(
                  //                       height: 1,
                  //                       fontSize: 17,
                  //                       fontWeight: FontWeight.w500,
                  //                       color: state.selectedThems.themeData
                  //                           .colorScheme.primary,
                  //                     ),
                  //                     children: [
                  //                   TextSpan(
                  //                       text: " • ",
                  //                       style: TextStyle(
                  //                           height: 1,
                  //                           color: state.selectedThems.themeData
                  //                               .colorScheme.primaryContainer)),
                  //                   TextSpan(
                  //                       text: "2030",
                  //                       style: TextStyle(
                  //                           height: 1,
                  //                           fontWeight: FontWeight.w500,
                  //                           color: state.selectedThems.themeData
                  //                               .colorScheme.primaryContainer)),
                  //                 ])),
                  //           ],
                  //         ),
                  //       ),
                  //       const CalendarHeader(),
                  //       CalendarSample(
                  //           itemHeight: itemHeight,
                  //           itemWidth: itemWidth,
                  //           monthHeight: monthHeight,
                  //           topPadding: topPadding,
                  //           lineHeight: lineHeight)
                  //     ],
                  //   ),
                  // ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPadding),
                    sliver: SliverList(
                      delegate:
                          SliverChildBuilderDelegate((context, sliverIndex) {
                        return GestureDetector(
                          onTap: () {
                            themeCubit
                                .selectTheme(state.appThemes[sliverIndex]);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, left: 0, right: 0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: Colors.grey.shade200))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.only(right: 16),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 4,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 2,
                                                childAspectRatio: 1),
                                        itemBuilder: (context, index) {
                                          return LayoutBuilder(
                                              builder: (context, constraint) {
                                            return ClipRRect(
                                                borderRadius: getBorderRadius(
                                                    index: index),
                                                child: Container(
                                                  height: constraint.maxHeight,
                                                  width: constraint.maxHeight,
                                                  color: getColor(
                                                      colorScheme: state
                                                          .appThemes[
                                                              sliverIndex]
                                                          .themeData
                                                          .colorScheme,
                                                      index: index),
                                                ));
                                          });
                                        },
                                      ),
                                    ),
                                    Text(
                                      state.appThemes[sliverIndex].name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                                // btn(sliverIndex: sliverIndex, state: state)\
                                // InkWell(
                                //   child: Container(
                                //     height: 30,
                                //     width: 30,
                                //     color: Colors.red,
                                //   ),
                                // )

                                IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.check,
                                      color: state.appThemes[sliverIndex].id ==
                                              state.selectedThems.id
                                          ? Colors.black
                                          : Colors.transparent),
                                  constraints: const BoxConstraints(),
                                  iconSize: 30,
                                  padding: EdgeInsets.zero,
                                )
                              ],
                            ),
                          ),
                        );
                      }, childCount: state.appThemes.length),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  BorderRadius getBorderRadius({required int index}) {
    if (index == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(8));
    } else if (index == 1) {
      return const BorderRadius.only(topRight: Radius.circular(8));
    } else if (index == 2) {
      return const BorderRadius.only(bottomLeft: Radius.circular(8));
    } else {
      return const BorderRadius.only(bottomRight: Radius.circular(8));
    }
  }

  Color getColor({required ColorScheme colorScheme, required int index}) {
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
