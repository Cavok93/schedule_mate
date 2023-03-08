import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_mate_clean/domain/entities/app_theme/app_theme.dart';
import 'package:today_mate_clean/presenter/widgets/color_card.dart';
import 'package:today_mate_clean/states/app_theme/app_theme_cubit.dart';

class AppThemeCard extends StatelessWidget {
  final AppTheme appTheme;
  final bool isSelected;
  const AppThemeCard(
      {super.key, required this.appTheme, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<AppThemeCubit>().selectTheme(appTheme);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 0, right: 0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey.shade200))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildGridView(),
                Text(
                  appTheme.name,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
            IconButton(
              onPressed: null,
              icon: Icon(Icons.check,
                  color: isSelected ? Colors.black : Colors.transparent),
              constraints: const BoxConstraints(),
              iconSize: 30,
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.only(right: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          return ColorCard(index: index, appTheme: appTheme);
        },
      ),
    );
  }
}
