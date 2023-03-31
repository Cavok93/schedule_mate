import 'dart:io';
import 'package:flutter/material.dart';
import 'package:today_mate_clean/presenter/widgets/app_theme_card.dart';
import '../../../../states/app_theme/app_theme_selector.dart';

class AppThemeBody extends StatelessWidget {
  const AppThemeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
              padding: EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  Platform.isAndroid
                      ? 16
                      : MediaQuery.of(context).padding.bottom),
              sliver: AppThemesSelector((appThemes) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, sliverIndex) {
                    final appTheme = appThemes[sliverIndex];
                    return AppThemeSelector(appTheme.id, (isSelected) {
                      return AppThemeCard(
                          appTheme: appTheme, isSelected: isSelected);
                    });
                  }, childCount: appThemes.length),
                );
              }))
        ],
      ),
    );
  }
}
