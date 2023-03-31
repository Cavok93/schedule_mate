import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:today_mate_clean/presenter/screens/splash/splash_screen.dart';
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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KO'),
            Locale('en', 'US'),
          ],
          color: Colors.white,
          title: 'ScheduleApp App',
          debugShowCheckedModeBanner: false,
          theme: selectedTheme.themeData.copyWith(
              textTheme: selectedTheme.themeData.textTheme
                  .apply(fontFamily: "NotoSans")),
          themeMode: ThemeMode.system,
          home: const SplashScreen(),
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
