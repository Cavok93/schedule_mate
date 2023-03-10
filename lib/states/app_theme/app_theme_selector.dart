// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:today_mate_clean/states/app_theme/app_theme_cubit.dart';

import '../../domain/entities/app_theme/app_theme.dart';

class AppThemeStateSelector<T>
    extends BlocSelector<AppThemeCubit, AppThemeState, T> {
  AppThemeStateSelector({
    super.key,
    required T Function(AppThemeState) selector,
    required Widget Function(T) builder,
  }) : super(
          selector: selector,
          builder: (_, value) {
            return builder(value);
          },
        );
}

class AppThemeStateStatusSelector
    extends AppThemeStateSelector<AppThemeStateStatus> {
  AppThemeStateStatusSelector(Widget Function(AppThemeStateStatus) builder,
      {super.key})
      : super(
          selector: (state) => state.status,
          builder: builder,
        );
}

class SelectAppThemeSelector extends AppThemeStateSelector<AppTheme> {
  SelectAppThemeSelector(Widget Function(AppTheme) builder, {super.key})
      : super(
          selector: (state) => state.selectedTheme,
          builder: builder,
        );
}

class AppThemesSelector extends AppThemeStateSelector<List<AppTheme>> {
  AppThemesSelector(Widget Function(List<AppTheme>) builder, {super.key})
      : super(
          selector: (state) => state.appThemes,
          builder: builder,
        );
}

class AppThemeSelector extends AppThemeStateSelector<AppThemeSelectorState> {
  AppThemeSelector(int id, Widget Function(bool) builder, {super.key})
      : super(
          selector: (state) => AppThemeSelectorState(
            state.selectedTheme.id == id,
          ),
          builder: (value) => builder(value.selected),
        );
}

class AppThemeSelectorState extends Equatable {
  final bool selected;

  const AppThemeSelectorState(this.selected);

  @override
  List<Object> get props => [selected];
}
