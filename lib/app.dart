import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/configs/routes.dart';
import 'package:today_mate_clean/states/theme/theme_cubit.dart';

class ScheduleApp extends StatefulWidget {
  const ScheduleApp({super.key});

  @override
  State<ScheduleApp> createState() => _ScheduleAppState();
}

class _ScheduleAppState extends State<ScheduleApp> {
  ThemeCubit get themeCubit => context.read<ThemeCubit>();

  @override
  void initState() {
    super.initState();
    themeCubit.setTheme();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    return MaterialApp(
      color: Colors.white,
      title: 'ScheduleApp App',
      theme: themeState.selectedThems.themeData,
      themeMode: ThemeMode.system,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      builder: (context, child) {
        if (child == null) return const SizedBox();
        return child;
      },
    );
  }
}
