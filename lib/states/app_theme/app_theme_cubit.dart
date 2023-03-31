import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/core/errors/failures.dart';
import 'package:today_mate_clean/domain/usecases/app_theme_usecases.dart';

import '../../domain/entities/app_theme/app_theme.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  final AppThemesUsecases appThemesUsecases;
  AppThemeCubit({required this.appThemesUsecases})
      : super(AppThemeState.initial());

  Future<void> setTheme() async {
    emit(state.copyWith(status: AppThemeStateStatus.loading));

    try {
      final int? id = await appThemesUsecases.getAppThemeIdUsecase();
      final selectedTheme =
          state.appThemes.firstWhereOrNull((theme) => theme.id == id);
      emit(state.copyWith(
          status: AppThemeStateStatus.loadSuccess,
          selectedTheme: selectedTheme));
    } on CacheFailure catch (e) {
      emit(state.copyWith(status: AppThemeStateStatus.loadFailure, failure: e));
    }
  }

  Future<void> selectTheme(AppTheme appTheme) async {
    try {
      await appThemesUsecases.setAppThemeIdUsecase(appTheme.id);
      emit(state.copyWith(selectedTheme: appTheme));
    } on CacheFailure catch (e) {
      emit(state.copyWith(status: AppThemeStateStatus.loadFailure, failure: e));
    }
  }
}
