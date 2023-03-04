import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/domain/usecases/app_theme_usecases.dart';
import '../../domain/entities/app_theme/app_theme.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AppThemesUsecases appThemesUsecases;
  ThemeCubit({required this.appThemesUsecases}) : super(ThemeState.initial());

  Future<void> setTheme() async {
    emit(state.copyWith(status: ThemeStateStatus.loading));

    try {
      final int? id = await appThemesUsecases.getAppThemeIdUsecase();
      final selectedTheme =
          state.appThemes.firstWhereOrNull((theme) => theme.id == id);
      emit(state.copyWith(
          status: ThemeStateStatus.loaded, selectedThems: selectedTheme));
    } catch (e) {
      log("$e");
    }
  }

  Future<void> selectTheme(AppTheme appTheme) async {
    try {
      await appThemesUsecases.setAppThemeIdUsecase(appTheme.id);
      emit(state.copyWith(selectedThems: appTheme));
    } catch (e) {
      log("$e");
    }
  }
}
