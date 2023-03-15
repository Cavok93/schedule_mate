import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/data/datasources/local/app_theme_preference.dart';
import 'package:today_mate_clean/data/datasources/local/schedule_database.dart';
import 'package:today_mate_clean/data/repositories/schedule_repository_impl.dart';
import 'package:today_mate_clean/domain/repositories/app_theme_repository.dart';
import 'package:today_mate_clean/domain/repositories/schedule_repository.dart';
import 'package:today_mate_clean/domain/usecases/app_theme/get_theme_id_usecase.dart';
import 'package:today_mate_clean/domain/usecases/app_theme/remove_theme_usecase.dart';
import 'package:today_mate_clean/domain/usecases/app_theme/set_theme_id_usecase.dart';
import 'package:today_mate_clean/domain/usecases/app_theme_usecases.dart';
import 'package:today_mate_clean/domain/usecases/schedule/create_schedule_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule/delete_schedule_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule/get_schedules_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule/update_schedule_usecase.dart';
import 'package:today_mate_clean/domain/usecases/schedule_usecases.dart.dart';
import 'package:today_mate_clean/states/app_theme/app_theme_cubit.dart';
import 'package:today_mate_clean/states/calendar/calendar_bloc.dart';

import 'package:today_mate_clean/states/schedule/schedule_bloc.dart';
import 'app.dart';
import 'data/repositories/app_theme_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ScheduleRepository>(
          create: (context) => ScheduleRepositoryImpl(
            scheduleDataBase: ScheduleDataBase(),
          ),
        ),
        RepositoryProvider<AppThemeRepository>(
          create: (context) => AppThemeRepositoryImpl(
            appThemePreference: AppThemePreference(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ScheduleBloc>(
            create: (context) => ScheduleBloc(
              scheduleUseCases: ScheduleUseCases(
                createScheduleUseCase: CreateScheduleUseCase(
                  scheduleRepository: context.read<ScheduleRepository>(),
                ),
                getSchedulesUseCase: GetSchedulesUseCase(
                  scheduleRepository: context.read<ScheduleRepository>(),
                ),
                updateScheduleUseCase: UpdateSchduleUseCase(
                  scheduleRepository: context.read<ScheduleRepository>(),
                ),
                deleteScheduleUseCase: DeleteScheduleUseCase(
                  scheduleRepository: context.read<ScheduleRepository>(),
                ),
              ),
            ),
          ),
          BlocProvider<CalendarBloc>(
            create: (context) => CalendarBloc(
              scheduleBloc: context.read<ScheduleBloc>(),
            ),
          ),
          BlocProvider<AppThemeCubit>(
            create: (context) => AppThemeCubit(
              appThemesUsecases: AppThemesUsecases(
                getAppThemeIdUsecase: GetAppThemeIdUsecase(
                  appThemeRepository: context.read<AppThemeRepository>(),
                ),
                setAppThemeIdUsecase: SetAppThemeIdUsecase(
                  appThemeRepository: context.read<AppThemeRepository>(),
                ),
                removeAppThemeIdUsecase: RemoveAppThemeIdUsecase(
                  appThemeRepository: context.read<AppThemeRepository>(),
                ),
              ),
            ),
          ),
        ],
        child: const ScheduleApp(),
      )));
}
