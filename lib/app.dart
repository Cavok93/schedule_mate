import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/configs/routes.dart';
import 'package:today_mate_clean/states/app_theme/app_theme_cubit.dart';
import 'package:today_mate_clean/states/app_theme/app_theme_selector.dart';

class ScheduleApp extends StatefulWidget {
  const ScheduleApp({super.key});

  @override
  State<ScheduleApp> createState() => _ScheduleAppState();
}

class _ScheduleAppState extends State<ScheduleApp> {
  AppThemeCubit get themeCubit => context.read<AppThemeCubit>();

  @override
  void initState() {
    super.initState();
    themeCubit.setTheme();
  }

  Widget _buildLoading() {
    return const SizedBox();
  }

  Widget _buildApp() {
    return SelectAppThemeSelector((selectedTheme) => MaterialApp(
          color: Colors.white,
          title: 'ScheduleApp App',
          theme: selectedTheme.themeData,
          themeMode: ThemeMode.system,
          navigatorKey: AppNavigator.navigatorKey,
          onGenerateRoute: AppNavigator.onGenerateRoute,
          builder: (context, child) {
            if (child == null) return const SizedBox();
            return child;
          },
        ));
  }

  Widget _buildError() {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeStateStatusSelector((status) {
      switch (status) {
        case AppThemeStateStatus.loading:
          return _buildLoading();
        case AppThemeStateStatus.loadSuccess:
          return _buildApp();
        case AppThemeStateStatus.loadFailure:
          return _buildError();
        default:
          return const SizedBox();
      }
    });
  }
}
