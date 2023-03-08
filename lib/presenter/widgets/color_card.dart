import 'package:flutter/material.dart';
import 'package:today_mate_clean/domain/entities/app_theme/app_theme.dart';

class ColorCard extends StatelessWidget {
  final int index;
  final AppTheme appTheme;
  const ColorCard({super.key, required this.index, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
          borderRadius: getBorderRadius(index: index),
          child: Container(
            height: constraint.maxHeight,
            width: constraint.maxHeight,
            color: getColor(
                colorScheme: appTheme.themeData.colorScheme, index: index),
          ));
    });
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
