import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/app_theme_body.dart';
import 'package:today_mate_clean/presenter/screens/home/widgets/app_theme_header.dart';

import '../../../../configs/constants.dart';
import '../../../../configs/routes.dart';
import '../../../../core/enums/week_day.dart';
import '../../../../states/app_theme/app_theme_cubit.dart';

class AppThemesScreen extends StatefulWidget {
  const AppThemesScreen({super.key});

  @override
  State<AppThemesScreen> createState() => _AppThemesScreenState();
}

class _AppThemesScreenState extends State<AppThemesScreen> {
  AppThemeCubit get themeCubit => context.read<AppThemeCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: true,
        title: const Text(
          "테마 컬러",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final double itemWidth = constraints.maxWidth / WeekDay.values.length;
        final double itemHeight = itemWidth * 2.13;
        const double itemInset = 3;
        final double monthHeight = itemWidth / 3;
        final double topPadding = itemWidth / 2;
        final double totalContentSize =
            itemHeight - topPadding - (WeekDay.values.length * itemInset);
        final double lineHeight =
            totalContentSize / CalendarElemetOptions.kMaxLines;
        return Column(
          children: [
            AppThemeHeader(
                itemHeight: itemHeight,
                itemWidth: itemWidth,
                lineHeight: lineHeight,
                monthHeight: monthHeight,
                topPadding: topPadding),
            const AppThemeBody(),
          ],
        );
      }),
    );
  }
}
